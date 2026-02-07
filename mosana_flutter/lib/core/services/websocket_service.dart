import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../utils/logger.dart';
import 'storage_service.dart';

/// WebSocket service for real-time updates
/// Connects to wss://api.mosana.xyz/notifications
class WebSocketService {
  final StorageService _storageService;
  IO.Socket? _socket;
  
  // Connection state
  bool _isConnected = false;
  bool _isConnecting = false;
  
  // Reconnection settings
  static const int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 3);
  int _reconnectAttempts = 0;
  Timer? _reconnectTimer;
  
  // Heart-beat to keep connection alive
  Timer? _heartbeatTimer;
  static const Duration _heartbeatInterval = Duration(seconds: 30);
  
  // Stream controllers for events
  final _notificationController = StreamController<Map<String, dynamic>>.broadcast();
  final _likeController = StreamController<Map<String, dynamic>>.broadcast();
  final _commentController = StreamController<Map<String, dynamic>>.broadcast();
  final _tipController = StreamController<Map<String, dynamic>>.broadcast();
  final _followController = StreamController<Map<String, dynamic>>.broadcast();
  final _mintController = StreamController<Map<String, dynamic>>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();
  
  // Public streams
  Stream<Map<String, dynamic>> get notificationStream => _notificationController.stream;
  Stream<Map<String, dynamic>> get likeStream => _likeController.stream;
  Stream<Map<String, dynamic>> get commentStream => _commentController.stream;
  Stream<Map<String, dynamic>> get tipStream => _tipController.stream;
  Stream<Map<String, dynamic>> get followStream => _followController.stream;
  Stream<Map<String, dynamic>> get mintStream => _mintController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  
  bool get isConnected => _isConnected;
  
  WebSocketService(this._storageService);
  
  /// Connect to WebSocket server
  Future<void> connect() async {
    if (_isConnected || _isConnecting) {
      AppLogger.logInfo('WebSocket already connected or connecting');
      return;
    }
    
    _isConnecting = true;
    
    try {
      // Get JWT token for authentication
      final token = await _storageService.getToken();
      if (token == null) {
        AppLogger.logWarning('No JWT token found, cannot connect to WebSocket');
        _isConnecting = false;
        return;
      }
      
      // WebSocket URL from config (TODO: Move to AppConfig)
      const wsUrl = 'https://api.mosana.xyz'; // Socket.IO will use /socket.io path
      
      AppLogger.logInfo('Connecting to WebSocket: $wsUrl');
      
      // Create socket with configuration
      _socket = IO.io(
        wsUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // Use WebSocket transport only
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionAttempts(_maxReconnectAttempts)
            .setReconnectionDelay(_reconnectDelay.inMilliseconds)
            .setAuth({'token': 'Bearer $token'}) // Send JWT in auth
            .build(),
      );
      
      // Set up event listeners
      _setupEventListeners();
      
      // Connect
      _socket!.connect();
      
    } catch (e, stackTrace) {
      AppLogger.logError('WebSocket connection error: $e', e, stackTrace);
      _isConnecting = false;
      _handleReconnect();
    }
  }
  
  /// Set up Socket.IO event listeners
  void _setupEventListeners() {
    if (_socket == null) return;
    
    // Connection events
    _socket!.onConnect((_) {
      AppLogger.logInfo('✅ WebSocket connected');
      _isConnected = true;
      _isConnecting = false;
      _reconnectAttempts = 0;
      _connectionController.add(true);
      _startHeartbeat();
    });
    
    _socket!.onDisconnect((_) {
      AppLogger.logWarning('❌ WebSocket disconnected');
      _isConnected = false;
      _connectionController.add(false);
      _stopHeartbeat();
      _handleReconnect();
    });
    
    _socket!.onConnectError((error) {
      AppLogger.logError('WebSocket connection error: $error');
      _isConnecting = false;
      _handleReconnect();
    });
    
    _socket!.onError((error) {
      AppLogger.logError('WebSocket error: $error');
    });
    
    // Notification events
    _socket!.on('notification', (data) {
      AppLogger.logInfo('📬 New notification received');
      _notificationController.add(data as Map<String, dynamic>);
    });
    
    _socket!.on('like', (data) {
      AppLogger.logInfo('❤️ New like received');
      _likeController.add(data as Map<String, dynamic>);
    });
    
    _socket!.on('comment', (data) {
      AppLogger.logInfo('💬 New comment received');
      _commentController.add(data as Map<String, dynamic>);
    });
    
    _socket!.on('tip', (data) {
      AppLogger.logInfo('💸 New tip received');
      _tipController.add(data as Map<String, dynamic>);
    });
    
    _socket!.on('follow', (data) {
      AppLogger.logInfo('👥 New follower');
      _followController.add(data as Map<String, dynamic>);
    });
    
    _socket!.on('mint', (data) {
      AppLogger.logInfo('✨ Post minted as NFT');
      _mintController.add(data as Map<String, dynamic>);
    });
    
    // Pong response for heartbeat
    _socket!.on('pong', (_) {
      AppLogger.debug('💓 Heartbeat pong received');
    });
  }
  
  /// Start heartbeat to keep connection alive
  void _startHeartbeat() {
    _stopHeartbeat(); // Cancel existing timer if any
    
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) {
      if (_isConnected && _socket != null) {
        AppLogger.debug('💓 Sending heartbeat ping');
        _socket!.emit('ping');
      }
    });
  }
  
  /// Stop heartbeat timer
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }
  
  /// Handle reconnection logic
  void _handleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      AppLogger.logWarning('Max reconnect attempts reached, giving up');
      return;
    }
    
    _reconnectTimer?.cancel();
    _reconnectAttempts++;
    
    AppLogger.logInfo('Reconnecting in ${_reconnectDelay.inSeconds}s (attempt $_reconnectAttempts/$_maxReconnectAttempts)');
    
    _reconnectTimer = Timer(_reconnectDelay, () {
      if (!_isConnected) {
        connect();
      }
    });
  }
  
  /// Send a custom event to the server
  void emit(String event, dynamic data) {
    if (!_isConnected || _socket == null) {
      AppLogger.logWarning('Cannot emit event, WebSocket not connected');
      return;
    }
    
    _socket!.emit(event, data);
    AppLogger.logInfo('📤 Emitted event: $event');
  }
  
  /// Disconnect from WebSocket
  Future<void> disconnect() async {
    AppLogger.logInfo('Disconnecting WebSocket');
    
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    
    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }
    
    _isConnected = false;
    _isConnecting = false;
    _reconnectAttempts = 0;
    
    _connectionController.add(false);
  }
  
  /// Dispose all resources
  Future<void> dispose() async {
    await disconnect();
    
    await _notificationController.close();
    await _likeController.close();
    await _commentController.close();
    await _tipController.close();
    await _followController.close();
    await _mintController.close();
    await _connectionController.close();
    
    AppLogger.logInfo('WebSocket service disposed');
  }
}

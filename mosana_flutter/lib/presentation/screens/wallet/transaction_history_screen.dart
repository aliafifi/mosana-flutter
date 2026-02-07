import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';

/// Screen showing all blockchain transactions
class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _selectedFilter = 'all';
  bool _isLoading = false;
  
  final List<String> _filters = ['all', 'tips', 'mints', 'follows'];
  
  // Mock transactions (TODO: Fetch from API)
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      type: TransactionType.tip,
      amount: 5.0,
      recipient: '@cryptoGiver',
      charity: 'Red Cross',
      status: TransactionStatus.confirmed,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      txHash: 'ABC123...XYZ789',
    ),
    Transaction(
      id: '2',
      type: TransactionType.mint,
      amount: 0.5,
      postTitle: 'Amazing sunset view',
      status: TransactionStatus.confirmed,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      txHash: 'DEF456...UVW012',
    ),
    Transaction(
      id: '3',
      type: TransactionType.tip,
      amount: 1.5,
      recipient: '@impactWarrior',
      charity: 'Water.org',
      status: TransactionStatus.pending,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      txHash: 'GHI789...RST345',
    ),
    Transaction(
      id: '4',
      type: TransactionType.follow,
      amount: 0.01,
      recipient: '@mosanaOfficial',
      status: TransactionStatus.confirmed,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      txHash: 'JKL012...OPQ678',
    ),
    Transaction(
      id: '5',
      type: TransactionType.mint,
      amount: 0.3,
      postTitle: 'First post on Mosana!',
      status: TransactionStatus.failed,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      txHash: 'MNO345...LMN901',
      errorMessage: 'Insufficient funds',
    ),
    Transaction(
      id: '6',
      type: TransactionType.tip,
      amount: 10.0,
      recipient: '@charityHero',
      charity: 'UNICEF',
      status: TransactionStatus.confirmed,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      txHash: 'PQR678...HIJ234',
    ),
  ];
  
  List<Transaction> get _filteredTransactions {
    if (_selectedFilter == 'all') return _transactions;
    return _transactions.where((tx) {
      switch (_selectedFilter) {
        case 'tips':
          return tx.type == TransactionType.tip;
        case 'mints':
          return tx.type == TransactionType.mint;
        case 'follows':
          return tx.type == TransactionType.follow;
        default:
          return true;
      }
    }).toList();
  }
  
  void _refreshTransactions() async {
    setState(() {
      _isLoading = true;
    });
    
    // TODO: Fetch from API
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  void _viewOnExplorer(String txHash) {
    // TODO: Open Solana explorer
    // https://explorer.solana.com/tx/$txHash
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening explorer for: $txHash'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final filteredTxs = _filteredTransactions;
    
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshTransactions,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    AppColors.mosanaPurple.withOpacity(0.15),
                    AppColors.pureBlack,
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Column(
              children: [
                // Filter chips
                _buildFilterChips(),
                
                // Transactions list
                Expanded(
                  child: _isLoading
                      ? _buildLoadingState()
                      : filteredTxs.isEmpty
                          ? _buildEmptyState()
                          : _buildTransactionsList(filteredTxs),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            _filters.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: index < _filters.length - 1 ? 8 : 0),
              child: _buildFilterChip(_filters[index]),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFilterChip(String filter) {
    final isSelected = _selectedFilter == filter;
    final label = filter[0].toUpperCase() + filter.substring(1);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: !isSelected ? AppColors.cardSurface.withOpacity(0.5) : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? Colors.transparent 
                : AppColors.textSecondary.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
  
  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.mosanaPurple),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your transaction history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTransactionsList(List<Transaction> transactions) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildTransactionCard(transactions[index]),
        );
      },
    );
  }
  
  Widget _buildTransactionCard(Transaction tx) {
    return GestureDetector(
      onTap: () => _viewOnExplorer(tx.txHash),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                // Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: _getTypeGradient(tx.type),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTypeIcon(tx.type),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getTypeTitle(tx),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeago.format(tx.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${tx.amount.toStringAsFixed(4)} SOL',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusBadge(tx.status, tx.errorMessage),
                  ],
                ),
              ],
            ),
            
            // Details
            if (tx.recipient != null || tx.charity != null || tx.postTitle != null) ...[
              const SizedBox(height: 12),
              const Divider(height: 1, color: Colors.white24),
              const SizedBox(height: 12),
              _buildTransactionDetails(tx),
            ],
            
            // Transaction hash
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.link,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    tx.txHash,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontFamily: 'monospace',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.open_in_new,
                  size: 14,
                  color: AppColors.mosanaBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusBadge(TransactionStatus status, String? errorMessage) {
    Color color;
    IconData icon;
    String label;
    
    switch (status) {
      case TransactionStatus.pending:
        color = AppColors.gold;
        icon = Icons.pending;
        label = 'Pending';
        break;
      case TransactionStatus.confirmed:
        color = AppColors.green;
        icon = Icons.check_circle;
        label = 'Confirmed';
        break;
      case TransactionStatus.failed:
        color = AppColors.red;
        icon = Icons.error;
        label = 'Failed';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTransactionDetails(Transaction tx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tx.recipient != null)
          _buildDetailRow('To', tx.recipient!),
        if (tx.charity != null) ...[
          const SizedBox(height: 6),
          _buildDetailRow('Charity', tx.charity!),
        ],
        if (tx.postTitle != null) ...[
          const SizedBox(height: 6),
          _buildDetailRow('Post', tx.postTitle!),
        ],
      ],
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  
  Gradient _getTypeGradient(TransactionType type) {
    switch (type) {
      case TransactionType.tip:
        return AppColors.goldGradient;
      case TransactionType.mint:
        return LinearGradient(
          colors: [AppColors.mosanaPurple, AppColors.mosanaBlue],
        );
      case TransactionType.follow:
        return LinearGradient(
          colors: [AppColors.green, Colors.teal],
        );
    }
  }
  
  IconData _getTypeIcon(TransactionType type) {
    switch (type) {
      case TransactionType.tip:
        return Icons.monetization_on;
      case TransactionType.mint:
        return Icons.auto_awesome;
      case TransactionType.follow:
        return Icons.person_add;
    }
  }
  
  String _getTypeTitle(Transaction tx) {
    switch (tx.type) {
      case TransactionType.tip:
        return 'Tip Sent';
      case TransactionType.mint:
        return 'NFT Minted';
      case TransactionType.follow:
        return 'Follow';
    }
  }
}

/// Transaction model
class Transaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String? recipient;
  final String? charity;
  final String? postTitle;
  final TransactionStatus status;
  final DateTime timestamp;
  final String txHash;
  final String? errorMessage;
  
  const Transaction({
    required this.id,
    required this.type,
    required this.amount,
    this.recipient,
    this.charity,
    this.postTitle,
    required this.status,
    required this.timestamp,
    required this.txHash,
    this.errorMessage,
  });
}

enum TransactionType { tip, mint, follow }

enum TransactionStatus { pending, confirmed, failed }

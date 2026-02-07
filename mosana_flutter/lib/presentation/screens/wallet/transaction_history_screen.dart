import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/user_avatar.dart';

/// Transaction types
enum TransactionType {
  tip,
  mint,
  follow,
  withdraw,
}

/// Transaction status
enum TransactionStatus {
  pending,
  confirmed,
  failed,
}

/// Transaction model
class Transaction {
  final String id;
  final TransactionType type;
  final TransactionStatus status;
  final double amount;
  final String? recipient;
  final String? recipientAvatar;
  final String? charity;
  final DateTime timestamp;
  final String? txHash; // Solana transaction hash
  final String? errorMessage;
  
  const Transaction({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    this.recipient,
    this.recipientAvatar,
    this.charity,
    required this.timestamp,
    this.txHash,
    this.errorMessage,
  });
}

/// Screen for viewing transaction history
class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  TransactionType? _filterType;
  
  // Mock transactions (TODO: Fetch from API/blockchain)
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      type: TransactionType.tip,
      status: TransactionStatus.confirmed,
      amount: 5.0,
      recipient: '@cryptoGiver',
      recipientAvatar: 'https://avatar.iran.liara.run/public/2',
      charity: 'Red Cross',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      txHash: '5vK7PZX...8hN9qW',
    ),
    Transaction(
      id: '2',
      type: TransactionType.mint,
      status: TransactionStatus.confirmed,
      amount: 0.012,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      txHash: '3mR2LYZ...6fT4pK',
    ),
    Transaction(
      id: '3',
      type: TransactionType.tip,
      status: TransactionStatus.confirmed,
      amount: 1.0,
      recipient: '@impactWarrior',
      recipientAvatar: 'https://avatar.iran.liara.run/public/3',
      charity: 'Water.org',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      txHash: '7xW9QMN...2cV5bR',
    ),
    Transaction(
      id: '4',
      type: TransactionType.tip,
      status: TransactionStatus.pending,
      amount: 0.5,
      recipient: '@mosanaOfficial',
      recipientAvatar: 'https://avatar.iran.liara.run/public/1',
      charity: 'UNICEF',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Transaction(
      id: '5',
      type: TransactionType.mint,
      status: TransactionStatus.failed,
      amount: 0.012,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      errorMessage: 'Insufficient funds',
    ),
    Transaction(
      id: '6',
      type: TransactionType.tip,
      status: TransactionStatus.confirmed,
      amount: 2.5,
      recipient: '@cryptoGiver',
      recipientAvatar: 'https://avatar.iran.liara.run/public/2',
      charity: 'Doctors Without Borders',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      txHash: '4nP8RXM...9dY6tL',
    ),
  ];
  
  List<Transaction> get _filteredTransactions {
    if (_filterType == null) {
      return _transactions;
    }
    return _transactions.where((tx) => tx.type == _filterType).toList();
  }
  
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              // TODO: Refresh transactions
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Refreshing transactions...'),
                  backgroundColor: AppColors.mosanaPurple,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
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
                // Summary stats
                _buildSummaryStats(),
                
                const SizedBox(height: 16),
                
                // Filter chips
                _buildFilterChips(),
                
                const SizedBox(height: 8),
                
                // Transaction list
                Expanded(
                  child: _filteredTransactions.isEmpty
                      ? _buildEmptyState()
                      : _buildTransactionList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryStats() {
    final totalSpent = _transactions
        .where((tx) => tx.status == TransactionStatus.confirmed)
        .fold<double>(0, (sum, tx) => sum + tx.amount);
    
    final totalTransactions = _transactions.length;
    final pendingCount = _transactions
        .where((tx) => tx.status == TransactionStatus.pending)
        .length;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Spent',
              '${totalSpent.toStringAsFixed(4)} SOL',
              Icons.trending_up,
              AppColors.mosanaPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Transactions',
              '$totalTransactions',
              Icons.receipt_long,
              AppColors.mosanaBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Pending',
              '$pendingCount',
              Icons.hourglass_empty,
              AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildFilterChip('All', null),
          const SizedBox(width: 8),
          _buildFilterChip('💸 Tips', TransactionType.tip),
          const SizedBox(width: 8),
          _buildFilterChip('✨ Mints', TransactionType.mint),
          const SizedBox(width: 8),
          _buildFilterChip('👥 Follows', TransactionType.follow),
        ],
      ),
    );
  }
  
  Widget _buildFilterChip(String label, TransactionType? type) {
    final isSelected = _filterType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _filterType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: isSelected ? null : AppColors.cardSurface.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? AppColors.mosanaPurple 
                : AppColors.cardSurface,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
  
  Widget _buildTransactionList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: _filteredTransactions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildTransactionCard(_filteredTransactions[index]),
        );
      },
    );
  }
  
  Widget _buildTransactionCard(Transaction tx) {
    return GestureDetector(
      onTap: () => _showTransactionDetails(tx),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Icon
                _buildTransactionIcon(tx),
                
                const SizedBox(width: 16),
                
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _getTransactionTitle(tx),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${tx.amount.toStringAsFixed(4)} SOL',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getTransactionSubtitle(tx),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Bottom row (status + time)
            Row(
              children: [
                _buildStatusBadge(tx.status, tx.errorMessage),
                const Spacer(),
                Text(
                  timeago.format(tx.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTransactionIcon(Transaction tx) {
    IconData icon;
    Color color;
    
    switch (tx.type) {
      case TransactionType.tip:
        icon = Icons.volunteer_activism;
        color = AppColors.gold;
        break;
      case TransactionType.mint:
        icon = Icons.diamond;
        color = AppColors.gold;
        break;
      case TransactionType.follow:
        icon = Icons.person_add;
        color = AppColors.mosanaBlue;
        break;
      case TransactionType.withdraw:
        icon = Icons.account_balance_wallet;
        color = AppColors.mosanaPurple;
        break;
    }
    
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
  
  String _getTransactionTitle(Transaction tx) {
    switch (tx.type) {
      case TransactionType.tip:
        return 'Tip to ${tx.recipient ?? 'User'}';
      case TransactionType.mint:
        return 'Minted as NFT';
      case TransactionType.follow:
        return 'Follow ${tx.recipient ?? 'User'}';
      case TransactionType.withdraw:
        return 'Withdrawal';
    }
  }
  
  String _getTransactionSubtitle(Transaction tx) {
    if (tx.type == TransactionType.tip && tx.charity != null) {
      return 'Supporting ${tx.charity}';
    }
    return _getTypeLabel(tx.type);
  }
  
  String _getTypeLabel(TransactionType type) {
    switch (type) {
      case TransactionType.tip:
        return 'Tip transaction';
      case TransactionType.mint:
        return 'NFT minting';
      case TransactionType.follow:
        return 'Follow transaction';
      case TransactionType.withdraw:
        return 'Withdrawal';
    }
  }
  
  Widget _buildStatusBadge(TransactionStatus status, String? errorMessage) {
    IconData icon;
    Color color;
    String label;
    
    switch (status) {
      case TransactionStatus.pending:
        icon = Icons.hourglass_empty;
        color = AppColors.gold;
        label = 'Pending';
        break;
      case TransactionStatus.confirmed:
        icon = Icons.check_circle;
        color = AppColors.green;
        label = 'Confirmed';
        break;
      case TransactionStatus.failed:
        icon = Icons.error;
        color = Colors.red;
        label = errorMessage ?? 'Failed';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Transactions Yet',
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
  
  void _showTransactionDetails(Transaction tx) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _TransactionDetailsSheet(transaction: tx),
    );
  }
}

/// Transaction details bottom sheet
class _TransactionDetailsSheet extends StatelessWidget {
  final Transaction transaction;
  
  const _TransactionDetailsSheet({required this.transaction});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.deepPurpleBlack,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Transaction Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Details
          _buildDetailRow('Type', _getTypeLabel(transaction.type)),
          const Divider(height: 24, color: Colors.white24),
          
          _buildDetailRow('Amount', '${transaction.amount.toStringAsFixed(4)} SOL'),
          const Divider(height: 24, color: Colors.white24),
          
          if (transaction.recipient != null)
            ...[
              _buildDetailRow('Recipient', transaction.recipient!),
              const Divider(height: 24, color: Colors.white24),
            ],
          
          if (transaction.charity != null)
            ...[
              _buildDetailRow('Charity', transaction.charity!),
              const Divider(height: 24, color: Colors.white24),
            ],
          
          _buildDetailRow('Status', _getStatusText(transaction.status)),
          const Divider(height: 24, color: Colors.white24),
          
          _buildDetailRow('Time', transaction.timestamp.toString().substring(0, 19)),
          
          if (transaction.txHash != null)
            ...[
              const Divider(height: 24, color: Colors.white24),
              _buildTransactionHashRow(context, transaction.txHash!),
            ],
          
          if (transaction.errorMessage != null)
            ...[
              const Divider(height: 24, color: Colors.white24),
              _buildDetailRow('Error', transaction.errorMessage!, isError: true),
            ],
          
          const SizedBox(height: 24),
          
          // View on Solana explorer button
          if (transaction.txHash != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Open Solana explorer
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening Solana Explorer...'),
                    ),
                  );
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('View on Solana Explorer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mosanaPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value, {bool isError = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isError ? Colors.red : Colors.white,
          ),
        ),
      ],
    );
  }
  
  Widget _buildTransactionHashRow(BuildContext context, String txHash) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Transaction Hash',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Row(
          children: [
            Text(
              txHash,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.mosanaBlue,
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy, size: 18, color: AppColors.mosanaBlue),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: txHash));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
  
  String _getTypeLabel(TransactionType type) {
    switch (type) {
      case TransactionType.tip:
        return 'Tip';
      case TransactionType.mint:
        return 'NFT Mint';
      case TransactionType.follow:
        return 'Follow';
      case TransactionType.withdraw:
        return 'Withdrawal';
    }
  }
  
  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.confirmed:
        return 'Confirmed';
      case TransactionStatus.failed:
        return 'Failed';
    }
  }
}

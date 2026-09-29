import 'package:flutter/material.dart';

import '../../theme/dashboard_colors.dart';

class _Txn {
  const _Txn(
    this.icon,
    this.color,
    this.name,
    this.time,
    this.category,
    this.amount,
  );
  final IconData icon;
  final Color color;
  final String name;
  final String time;
  final String category;
  final String amount;
}

const _transactions = [
  _Txn(
    Icons.shopping_cart_rounded,
    DashboardColors.blue,
    'Indomie Goreng',
    '09:35',
    'Retail',
    'Rp 12.000',
  ),
  _Txn(
    Icons.phone_android_rounded,
    DashboardColors.magenta,
    'Pulsa Telkomsel 50rb',
    '09:22',
    'Pulsa',
    'Rp 50.500',
  ),
  _Txn(
    Icons.bolt_rounded,
    DashboardColors.orange,
    'Token PLN 100rb',
    '09:10',
    'PPOB',
    'Rp 100.000',
  ),
  _Txn(
    Icons.water_drop_rounded,
    DashboardColors.blue,
    'PDAM Jakarta',
    '08:55',
    'PPOB',
    'Rp 150.000',
  ),
  _Txn(
    Icons.shopping_cart_rounded,
    DashboardColors.blue,
    'Aqua 600ml',
    '08:40',
    'Retail',
    'Rp 6.000',
  ),
];

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DashboardColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaksi Terbaru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: DashboardColors.textPrimary,
                ),
              ),
              const Text(
                'Lihat Semua',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: DashboardColors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _FilterDropdown(label: 'Semua')),
              SizedBox(width: 8),
              Expanded(child: _FilterDropdown(label: 'Hari Ini')),
            ],
          ),
          const SizedBox(height: 4),
          for (final t in _transactions)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: t.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(t.icon, color: t.color, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.name,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: DashboardColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${t.time} • ${t.category}',
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: DashboardColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        t.amount,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: DashboardColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: DashboardColors.statusGood.withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Selesai',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: DashboardColors.deltaUpGood,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.more_vert_rounded,
                    size: 18,
                    color: DashboardColors.textMuted,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: DashboardColors.divider),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: DashboardColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: DashboardColors.textMuted,
          ),
        ],
      ),
    );
  }
}

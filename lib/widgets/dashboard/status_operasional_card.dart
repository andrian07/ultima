import 'package:flutter/material.dart';

import '../../theme/dashboard_colors.dart';

const _items = [
  _StatusItem(
    icon: Icons.people_alt_rounded,
    color: DashboardColors.aqua,
    value: '2',
    label: 'Kasir Aktif',
    sublabel: 'dari 4 kasir',
  ),
  _StatusItem(
    icon: Icons.access_time_filled_rounded,
    color: DashboardColors.orange,
    value: '3',
    label: 'Transaksi Pending',
    sublabel: 'perlu diproses',
  ),
  _StatusItem(
    icon: Icons.receipt_long_rounded,
    color: DashboardColors.violet,
    value: '1',
    label: 'PPOB Pending',
    sublabel: 'menunggu konfirmasi',
  ),
  _StatusItem(
    icon: Icons.inventory_2_rounded,
    color: DashboardColors.magenta,
    value: '12',
    label: 'Stok Menipis',
    sublabel: 'produk',
  ),
  _StatusItem(
    icon: Icons.account_balance_wallet_rounded,
    color: DashboardColors.blue,
    value: 'Rp 8.500.000',
    label: 'Saldo PPOB',
    actionLabel: 'Top Up',
  ),
];

class StatusOperasionalCard extends StatelessWidget {
  const StatusOperasionalCard({super.key});

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
          const Text(
            'Status Operasional',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: DashboardColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              // Fit all 5 items on one row when there's room; otherwise
              // fall back to a wrapping grid so nothing gets clipped.
              final bool singleRow = constraints.maxWidth >= 720;
              if (singleRow) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < _items.length; i++) ...[
                      if (i != 0) const SizedBox(width: 10),
                      Expanded(child: _items[i]),
                    ],
                  ],
                );
              }
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final item in _items)
                    SizedBox(
                      width: (constraints.maxWidth - 10) / 2,
                      child: item,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  const _StatusItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
    this.sublabel,
    this.actionLabel,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;
  final String? sublabel;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: DashboardColors.divider),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 17),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.2,
                    color: DashboardColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: value.length > 6 ? 17 : 20,
              fontWeight: FontWeight.w700,
              color: DashboardColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          if (actionLabel != null)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  side: const BorderSide(color: DashboardColors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: DashboardColors.blue,
                  ),
                ),
              ),
            )
          else
            Text(
              sublabel ?? '',
              style: const TextStyle(
                fontSize: 12,
                color: DashboardColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}

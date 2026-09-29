import 'package:flutter/material.dart';

import '../../theme/dashboard_colors.dart';

class _Product {
  const _Product(this.rank, this.color, this.name, this.sold, this.progress);
  final int rank;
  final Color color;
  final String name;
  final String sold;
  final double progress;
}

const _products = [
  _Product(1, DashboardColors.blue, 'Indomie Goreng', '48 terjual', 1.0),
  _Product(2, DashboardColors.blue, 'Aqua 600ml', '36 terjual', 0.75),
  _Product(3, DashboardColors.blue, 'Pulsa Telkomsel 50rb', '28 terjual', 0.58),
  _Product(4, DashboardColors.blue, 'Token PLN 100rb', '24 terjual', 0.5),
  _Product(5, DashboardColors.blue, 'Kopi ABC', '20 terjual', 0.42),
];

class TopProductsCard extends StatelessWidget {
  const TopProductsCard({super.key});

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
            children: [
              const Expanded(
                child: Text(
                  'Produk Terlaris',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: DashboardColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: DashboardColors.divider),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hari Ini',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: DashboardColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: DashboardColors.textMuted,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
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
          const SizedBox(height: 14),
          for (final p in _products)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: p.color,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${p.rank}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                p.name,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w600,
                                  color: DashboardColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              p.sold,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: DashboardColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: p.progress,
                            minHeight: 6,
                            backgroundColor: DashboardColors.pageBackground,
                            valueColor: AlwaysStoppedAnimation(p.color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

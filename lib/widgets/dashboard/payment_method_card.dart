import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../theme/dashboard_colors.dart';

class _PaymentMethod {
  const _PaymentMethod(this.label, this.percent, this.amount, this.color);
  final String label;
  final double percent;
  final String amount;
  final Color color;
}

const _methods = [
  _PaymentMethod('Cash', 40, 'Rp 2.150.000', DashboardColors.blue),
  _PaymentMethod('QRIS', 34, 'Rp 1.850.000', DashboardColors.aqua),
  _PaymentMethod('Debit', 17, 'Rp 920.000', DashboardColors.orange),
  _PaymentMethod('E-Wallet', 9, 'Rp 500.000', DashboardColors.violet),
];

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

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
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: DashboardColors.textPrimary,
                ),
              ),
              _FilterDropdown(label: 'Hari Ini'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 48,
                    sections: [
                      for (final m in _methods)
                        PieChartSectionData(
                          value: m.percent,
                          color: m.color,
                          radius: 26,
                          showTitle: false,
                        ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: DashboardColors.textMuted,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Rp 5.420.000',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: DashboardColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final m in _methods)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: m.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      m.label,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: DashboardColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${m.percent.toInt()}%',
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: DashboardColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    m.amount,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: DashboardColors.textMuted,
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
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: DashboardColors.textSecondary,
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

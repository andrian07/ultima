import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../theme/dashboard_colors.dart';

const _tabs = ['Semua', 'Retail', 'Pulsa & PPOB'];

const _xLabels = [
  '20 Sep',
  '21 Sep',
  '22 Sep',
  '23 Sep',
  '24 Sep',
  '25 Sep',
  '26 Sep',
];

const Map<String, List<double>> _series = {
  'Semua': [780000, 950000, 900000, 1150000, 1480000, 1520000, 1980000],
  'Retail': [320000, 410000, 380000, 520000, 640000, 610000, 820000],
  'Pulsa & PPOB': [460000, 540000, 520000, 630000, 840000, 910000, 1160000],
};

class SalesChartCard extends StatefulWidget {
  const SalesChartCard({super.key});

  @override
  State<SalesChartCard> createState() => _SalesChartCardState();
}

class _SalesChartCardState extends State<SalesChartCard> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = _series[_tabs[_tabIndex]]!;
    final maxY = 2000000.0;

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
            children: [
              const Text(
                'Grafik Penjualan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: DashboardColors.textPrimary,
                ),
              ),
              _PeriodDropdown(),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (int i = 0; i < _tabs.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _TabChip(
                    label: _tabs[i],
                    active: i == _tabIndex,
                    onTap: () => setState(() => _tabIndex = i),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: maxY,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: maxY / 4,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: DashboardColors.divider,
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 54,
                          interval: maxY / 4,
                          getTitlesWidget: (value, meta) => Text(
                            value == 0
                                ? '0'
                                : '${(value / 1000000).toStringAsFixed(1)}M',
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: DashboardColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final i = value.toInt();
                            if (i < 0 || i >= _xLabels.length) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                _xLabels[i],
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: DashboardColors.textMuted,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => DashboardColors.textPrimary,
                        getTooltipItems: (spots) => spots.map((s) {
                          return LineTooltipItem(
                            'Rp ${s.y.toInt()}',
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        barWidth: 2.5,
                        color: DashboardColors.blue,
                        dotData: FlDotData(
                          show: true,
                          checkToShowDot: (spot, barData) =>
                              spot.x == data.length - 1,
                          getDotPainter: (spot, percent, bar, index) =>
                              FlDotCirclePainter(
                                radius: 4,
                                color: DashboardColors.blue,
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              DashboardColors.blue.withValues(alpha: 0.22),
                              DashboardColors.blue.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                        spots: [
                          for (int i = 0; i < data.length; i++)
                            FlSpot(i.toDouble(), data[i]),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 8,
                  child: _ChartAnnotation(
                    amount: data.last,
                    label: '${_xLabels.last} ${DateTime.now().year}',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(
                child: _MiniSummary(
                  icon: Icons.attach_money_rounded,
                  color: DashboardColors.aqua,
                  value: 'Rp 5.420.000',
                  label: 'Omzet 7 Hari',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MiniSummary(
                  icon: Icons.shopping_cart_rounded,
                  color: DashboardColors.blue,
                  value: '248',
                  label: 'Total Transaksi',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MiniSummary(
                  icon: Icons.receipt_long_rounded,
                  color: DashboardColors.violet,
                  value: 'Rp 21.855',
                  label: 'Rata-rata Transaksi',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartAnnotation extends StatelessWidget {
  const _ChartAnnotation({required this.amount, required this.label});

  final double amount;
  final String label;

  @override
  Widget build(BuildContext context) {
    final formatted = amount.toInt().toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (m) => '.',
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: DashboardColors.textPrimary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rp $formatted',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniSummary extends StatelessWidget {
  const _MiniSummary({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: DashboardColors.pageBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: DashboardColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: DashboardColors.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active
                ? DashboardColors.blue
                : DashboardColors.pageBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: active ? Colors.white : DashboardColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _PeriodDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: DashboardColors.divider),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '7 Hari Terakhir',
            style: TextStyle(
              fontSize: 14,
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
    );
  }
}

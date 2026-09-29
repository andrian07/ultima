import 'package:flutter/material.dart';

import '../../theme/dashboard_colors.dart';

const _idDayNames = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

const _idMonthNames = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

String _formatIndonesianDate(DateTime date) {
  final day = _idDayNames[date.weekday - 1];
  final month = _idMonthNames[date.month - 1];
  return '$day, ${date.day} $month ${date.year}';
}

String _formatTime(DateTime date) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(date.hour)}:${two(date.minute)}';
}

class DashboardTopBar extends StatelessWidget {
  const DashboardTopBar({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateLabel = _formatIndonesianDate(now);
    final timeLabel = _formatTime(now);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 760;
        return Container(
          height: 76,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: DashboardColors.divider)),
          ),
          child: Row(
            children: [
              if (onMenuTap != null)
                IconButton(
                  onPressed: onMenuTap,
                  icon: const Icon(Icons.menu_rounded),
                  color: DashboardColors.textSecondary,
                ),
              Expanded(
                child: Container(
                  height: 44,
                  constraints: const BoxConstraints(maxWidth: 420),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: DashboardColors.pageBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 18,
                        color: DashboardColors.textMuted,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Cari produk, pelanggan, transaksi atau kode...',
                          style: const TextStyle(
                            color: DashboardColors.textMuted,
                            fontSize: 14.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!compact)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: DashboardColors.divider),
                          ),
                          child: const Text(
                            'Ctrl + K',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: DashboardColors.textMuted,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              if (!compact) ...[
                _PillButton(
                  icon: Icons.storefront_outlined,
                  label: 'Cabang Utama',
                ),
                const SizedBox(width: 12),
                _PillButton(
                  icon: Icons.calendar_today_outlined,
                  label: '$dateLabel\n$timeLabel',
                  twoLine: true,
                ),
                const SizedBox(width: 16),
              ],
              const _NotificationBell(),
              const SizedBox(width: 12),
              _ProfileMenu(compact: compact),
            ],
          ),
        );
      },
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.icon,
    required this.label,
    this.twoLine = false,
  });

  final IconData icon;
  final String label;
  final bool twoLine;

  @override
  Widget build(BuildContext context) {
    final parts = label.split('\n');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: DashboardColors.pageBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: DashboardColors.textSecondary),
          const SizedBox(width: 8),
          if (twoLine)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  parts[0],
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: DashboardColors.textPrimary,
                  ),
                ),
                Text(
                  parts.length > 1 ? parts[1] : '',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: DashboardColors.textMuted,
                  ),
                ),
              ],
            )
          else
            Text(
              parts[0],
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                color: DashboardColors.textPrimary,
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

class _NotificationBell extends StatelessWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Icon(
              Icons.notifications_outlined,
              color: DashboardColors.textSecondary,
              size: 22,
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFE34948),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 17,
          backgroundColor: DashboardColors.blue,
          child: Icon(Icons.person, color: Colors.white, size: 18),
        ),
        if (!compact) ...[
          const SizedBox(width: 8),
          const Text(
            'Admin',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
              color: DashboardColors.textPrimary,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: DashboardColors.textMuted,
          ),
        ],
      ],
    );
  }
}

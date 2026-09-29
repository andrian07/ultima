import 'package:flutter/material.dart';

import '../../theme/dashboard_colors.dart';

class SidebarItem {
  const SidebarItem(this.icon, this.label);
  final IconData icon;
  final String label;
}

class SidebarGroup {
  const SidebarGroup(this.title, this.items);
  final String title;
  final List<SidebarItem> items;
}

const List<SidebarGroup> sidebarGroups = [
  SidebarGroup('UTAMA', [SidebarItem(Icons.dashboard_rounded, 'Dashboard')]),
  SidebarGroup('TRANSAKSI', [
    SidebarItem(Icons.shopping_cart_outlined, 'Penjualan'),
    SidebarItem(Icons.receipt_long_outlined, 'Transaksi'),
    SidebarItem(Icons.phone_android_outlined, 'Pulsa & PPOB'),
  ]),
  SidebarGroup('MASTER', [
    SidebarItem(Icons.inventory_2_outlined, 'Produk'),
    SidebarItem(Icons.people_outline, 'Pelanggan'),
  ]),
  SidebarGroup('LAPORAN', [SidebarItem(Icons.bar_chart_outlined, 'Laporan')]),
  SidebarGroup('SISTEM', [SidebarItem(Icons.settings_outlined, 'Pengaturan')]),
];

/// Flattened items in display order, so a flat [selectedIndex] still maps
/// to the right item across group boundaries.
final List<SidebarItem> sidebarItems = [
  for (final g in sidebarGroups) ...g.items,
];

class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    required this.onLogout,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [DashboardColors.sidebarTop, DashboardColors.sidebarBottom],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
            child: Row(
              children: [
                Image.asset('asset/logo.png', height: 34),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                    children: [
                      TextSpan(
                        text: 'ULTIMA ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'POS',
                        style: TextStyle(color: Color(0xFF25C8FB)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: [
                for (int g = 0; g < sidebarGroups.length; g++) ...[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, g == 0 ? 4 : 18, 10, 8),
                    child: Text(
                      sidebarGroups[g].title,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  for (final item in sidebarGroups[g].items)
                    _SidebarTile(
                      item: item,
                      active: sidebarItems.indexOf(item) == selectedIndex,
                      onTap: () => onSelect(sidebarItems.indexOf(item)),
                    ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onLogout,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.white70,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final SidebarItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: active ? const Color(0xFF2A78D6) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: active ? Colors.white : Colors.white60,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: TextStyle(
                    color: active ? Colors.white : Colors.white70,
                    fontSize: 15.5,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

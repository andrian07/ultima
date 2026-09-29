import 'package:flutter/material.dart';

import '../theme/dashboard_colors.dart';
import '../widgets/dashboard/app_sidebar.dart';
import '../widgets/dashboard/dashboard_topbar.dart';
import '../widgets/dashboard/payment_method_card.dart';
import '../widgets/dashboard/quick_action_tile.dart';
import '../widgets/dashboard/recent_transactions_card.dart';
import '../widgets/dashboard/sales_chart_card.dart';
import '../widgets/dashboard/stat_card.dart';
import '../widgets/dashboard/status_operasional_card.dart';
import '../widgets/dashboard/top_products_card.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 900;

    final sidebar = AppSidebar(
      selectedIndex: _selectedIndex,
      onSelect: (i) {
        setState(() => _selectedIndex = i);
        if (!isWide) Navigator.of(context).pop();
      },
      onLogout: _logout,
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: DashboardColors.pageBackground,
      drawer: isWide
          ? null
          : Drawer(width: 240, child: SafeArea(child: sidebar)),
      body: Row(
        children: [
          if (isWide) SizedBox(width: 230, child: SafeArea(child: sidebar)),
          Expanded(
            child: Column(
              children: [
                DashboardTopBar(
                  onMenuTap: isWide
                      ? null
                      : () => _scaffoldKey.currentState?.openDrawer(),
                ),
                const Expanded(child: _DashboardContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wide = constraints.maxWidth >= 900;
        final bool medium = constraints.maxWidth >= 620;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WelcomeHeader(wide: wide),
              const SizedBox(height: 20),
              _StatsRow(medium: medium),
              const SizedBox(height: 20),
              if (wide)
                const IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 5, child: SalesChartCard()),
                      SizedBox(width: 16),
                      Expanded(flex: 3, child: PaymentMethodCard()),
                      SizedBox(width: 16),
                      Expanded(flex: 4, child: RecentTransactionsCard()),
                    ],
                  ),
                )
              else ...[
                const SalesChartCard(),
                const SizedBox(height: 16),
                const PaymentMethodCard(),
                const SizedBox(height: 16),
                const RecentTransactionsCard(),
              ],
              const SizedBox(height: 20),
              if (wide)
                const IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 3, child: StatusOperasionalCard()),
                      SizedBox(width: 16),
                      Expanded(flex: 2, child: TopProductsCard()),
                    ],
                  ),
                )
              else ...[
                const StatusOperasionalCard(),
                const SizedBox(height: 16),
                const TopProductsCard(),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w700,
              color: DashboardColors.textPrimary,
            ),
            children: [
              TextSpan(text: 'Selamat datang, '),
              TextSpan(
                text: 'Admin',
                style: TextStyle(color: DashboardColors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Kelola penjualan retail, pulsa & PPOB dengan mudah',
          style: TextStyle(
            fontSize: 14.5,
            color: DashboardColors.textSecondary,
          ),
        ),
      ],
    );

    final actions = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          QuickActionTile(
            icon: Icons.shopping_cart_rounded,
            label: 'Transaksi Baru',
            color: DashboardColors.blue,
            shortcut: 'F2',
          ),
          SizedBox(width: 12),
          QuickActionTile(
            icon: Icons.smartphone_rounded,
            label: 'Top Up Pulsa',
            color: DashboardColors.magenta,
            shortcut: 'F3',
          ),
          SizedBox(width: 12),
          QuickActionTile(
            icon: Icons.receipt_long_rounded,
            label: 'PPOB',
            color: DashboardColors.violet,
            shortcut: 'F4',
          ),
          SizedBox(width: 12),
          QuickActionTile(
            icon: Icons.widgets_rounded,
            label: 'Tambah Produk',
            color: DashboardColors.orange,
            shortcut: 'F5',
          ),
        ],
      ),
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: header),
          const SizedBox(width: 16),
          actions,
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [header, const SizedBox(height: 16), actions],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.medium});

  final bool medium;

  @override
  Widget build(BuildContext context) {
    const cards = [
      StatCard(
        icon: Icons.attach_money_rounded,
        accentColor: DashboardColors.aqua,
        title: 'Total Penjualan',
        value: 'Rp 5.420.000',
        deltaLabel: '18%',
        sparkline: [3, 5, 4, 6, 7, 8, 10],
      ),
      StatCard(
        icon: Icons.shopping_cart_rounded,
        accentColor: DashboardColors.blue,
        title: 'Total Transaksi',
        value: '248',
        deltaLabel: '12%',
        sparkline: [4, 6, 5, 7, 8, 7, 9],
      ),
      StatCard(
        icon: Icons.bar_chart_rounded,
        accentColor: DashboardColors.orange,
        title: 'Profit (Estimasi)',
        value: 'Rp 1.245.000',
        deltaLabel: '15%',
        sparkline: [2, 3, 3, 5, 6, 7, 9],
      ),
      StatCard(
        icon: Icons.description_rounded,
        accentColor: DashboardColors.violet,
        title: 'Transaksi Pulsa & PPOB',
        value: '92',
        deltaLabel: '25%',
        sparkline: [2, 3, 4, 4, 6, 7, 8],
      ),
    ];

    if (!medium) {
      return Column(
        children: [
          for (final c in cards) ...[c, const SizedBox(height: 12)],
        ],
      );
    }

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(child: cards[i]),
          if (i != cards.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

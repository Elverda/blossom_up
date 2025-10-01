import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:solo/models/admin.dart';
import 'package:solo/login_page.dart';

class AdminDashboardScreen extends StatefulWidget {
  final Admin admin;

  const AdminDashboardScreen({Key? key, required this.admin}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _mockOrders = [
    {
      'user': 'user',
      'status': 'completed',
      'date': '2025-09-18',
      'items': [
        {'nama': 'BUKET BUNGA MERAH', 'price': 75000},
        {'nama': 'BUKET BUNGA PINK', 'price': 80000},
      ],
    },
    {
      'user': 'user coba',
      'status': 'processing',
      'date': '2025-09-18',
      'items': [
        {'nama': 'BUKET BUNGA UNGU', 'price': 85000},
      ],
    },
    {
      'user': 'izora',
      'status': 'pending',
      'date': '2025-09-17',
      'items': [
        {'nama': 'BUKET BUNGA MERAH', 'price': 75000},
        {'nama': 'BUKET UANG', 'price': 150000},
        {'nama': 'BUKET BUNGA MERAH', 'price': 75000},
      ],
    },
    {
      'user': 'izo',
      'status': 'completed',
      'date': '2025-09-17',
      'items': [
        {'nama': 'BUKET BUNGA PINK', 'price': 80000},
        {'nama': 'BUKET BUNGA MIX', 'price': 95000},
      ],
    },
  ];

  String _getImageAsset(String productName) {
    switch (productName.toUpperCase()) {
      case 'BUKET BUNGA MERAH':
        return 'assets/images/buket_merah.jpeg';
      case 'BUKET BUNGA PINK':
        return 'assets/images/buket_pink.jpeg';
      case 'BUKET BUNGA UNGU':
        return 'assets/images/buket_ungu.jpeg';
      case 'BUKET BUNGA MIX':
        return 'assets/images/buket_mix.jpeg';
      case 'BUKET UANG':
        return 'assets/images/buket_uang.jpeg';
      default:
        return 'assets/images/buket_default.jpg';
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Map<String, int> _prepareChartData() {
    Map<String, int> itemCounts = {};
    for (var order in _mockOrders) {
      for (var item in (order['items'] as List)) {
        itemCounts[item['nama']] = (itemCounts[item['nama']] ?? 0) + 1;
      }
    }
    return itemCounts;
  }

  int _getTotalRevenue() {
    int total = 0;
    for (var order in _mockOrders) {
      for (var item in (order['items'] as List)) {
        total += (item['price'] as int);
      }
    }
    return total;
  }

  int _getTotalOrders() {
    return _mockOrders.length;
  }

  int _getCompletedOrders() {
    return _mockOrders.where((order) => order['status'] == 'completed').length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildStatsCards(),
                      const SizedBox(height: 25),
                      _buildSalesChartCard(),
                      const SizedBox(height: 25),
                      _buildRecentOrdersList(),
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

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667eea),
                Color(0xFF764ba2),
                Color(0xFFacc3f6),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/coba.jpeg'),
                          child: Text(''),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back,',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.admin.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Billioner, You Tuber, AI Developer, Web Developer,',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Revenue',
            'Rp ${_getTotalRevenue().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            Icons.account_balance_wallet,
            const LinearGradient(
              colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            'Total Orders',
            _getTotalOrders().toString(),
            Icons.shopping_bag,
            const LinearGradient(
              colors: [Color(0xFFfc466b), Color(0xFF3f5efb)],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            'Completed',
            _getCompletedOrders().toString(),
            Icons.check_circle,
            const LinearGradient(
              colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Gradient gradient) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesChartCard() {
    final chartData = _prepareChartData();
    final List<BarChartGroupData> barGroups = [];
    int i = 0;

    final gradientColors = [
      const LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
      const LinearGradient(colors: [Color(0xFFf093fb), Color(0xFFf5576c)]),
      const LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)]),
      const LinearGradient(colors: [Color(0xFF43e97b), Color(0xFF38f9d7)]),
      const LinearGradient(colors: [Color(0xFFfa709a), Color(0xFFfee140)]),
    ];

    chartData.forEach((key, value) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value.toDouble(),
              gradient: gradientColors[i % gradientColors.length],
              width: 20,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ],
        ),
      );
      i++;
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.bar_chart, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales Analytics',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2c3e50),
                        ),
                      ),
                      Text(
                        'Product performance overview',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (chartData.values.isEmpty ? 0 : chartData.values.reduce((a, b) => a > b ? a : b)) + 2.0,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String productName = chartData.keys.elementAt(group.x);
                        return BarTooltipItem(
                          '$productName\n',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${rod.toY.toInt()} orders',
                              style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.w500),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < chartData.keys.length) {
                            final text = chartData.keys.elementAt(index).split(' ').take(2).join('\n');
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8.0,
                              child: Text(
                                text,
                                style: const TextStyle(fontSize: 10, color: Color(0xFF7f8c8d)),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const Text('');
                        },
                        reservedSize: 45,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) {
                          if (value % 1 == 0) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10, color: Color(0xFF7f8c8d)),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: barGroups,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xFFecf0f1),
                        strokeWidth: 1,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrdersList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFfc466b), Color(0xFF3f5efb)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.receipt_long, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2c3e50),
                        ),
                      ),
                      Text(
                        'Latest customer transactions',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ..._mockOrders.asMap().entries.map((entry) {
              int index = entry.key;
              var order = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFE9ECEF), width: 1),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getStatusIcon(order['status']),
                        color: _getStatusColor(order['status']),
                        size: 20,
                      ),
                    ),
                    title: Text(
                      'Order ${index + 1} - ${order['user']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2c3e50),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order['status']),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            order['status'].toString().toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          order['date'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ...(order['items'] as List).map((item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          _getImageAsset(item['nama']),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.local_florist,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['nama'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF2c3e50),
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Rp ${item['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                            style: TextStyle(
                                              color: Colors.green[600],
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return const Color(0xFF27ae60);
      case 'processing':
        return const Color(0xFFf39c12);
      case 'pending':
        return const Color(0xFFe74c3c);
      default:
        return const Color(0xFF95a5a6);
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'processing':
        return Icons.sync;
      case 'pending':
        return Icons.pending;
      default:
        return Icons.help;
    }
  }
}
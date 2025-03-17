import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedTimeRange = '1M';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Overview'),
            Tab(text: 'Assets'),
            Tab(text: 'Performance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildAssetsTab(),
          _buildPerformanceTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to add a new asset
        },
        child: Icon(Icons.add),
        tooltip: 'Add Asset',
      ),
    );
  }

  // Overview Tab: Portfolio summary with header and charts
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPortfolioHeader(),
          _buildAssetAllocationChart(),
          _buildQuickAssetList(),
        ],
      ),
    );
  }

  // Assets Tab: Detailed list of individual assets
  Widget _buildAssetsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5, // Replace with dynamic data
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(child: Text('A$index')),
            title: Text('Asset $index'),
            subtitle: Text('\$5,000'),
            trailing: Text(
              '+3.2%',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {
              // Navigate to asset details
            },
          ),
        );
      },
    );
  }

  // Performance Tab: Interactive line chart with time range selector
  Widget _buildPerformanceTab() {
    return Column(
      children: [
        _buildTimeRangeSelector(),
        Expanded(
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 3),
                    FlSpot(1, 1),
                    FlSpot(2, 4),
                    FlSpot(3, 2),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                ),
              ],
              titlesData: FlTitlesData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  // Header: Total portfolio value with gradient background
  Widget _buildPortfolioHeader() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Total Portfolio Value',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            '\$50,000',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '+2.5% today',
            style: TextStyle(color: Colors.greenAccent, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Pie Chart: Asset allocation visualization
  Widget _buildAssetAllocationChart() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 40, color: Colors.blue, title: 'Stocks'),
            PieChartSectionData(value: 30, color: Colors.green, title: 'Crypto'),
            PieChartSectionData(value: 20, color: Colors.orange, title: 'Cash'),
            PieChartSectionData(value: 10, color: Colors.red, title: 'Others'),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  // Quick Asset List: Preview of top assets
  Widget _buildQuickAssetList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3, // Limited preview
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Asset $index'),
          subtitle: Text('\$5,000 • +3.2%'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to asset details
          },
        );
      },
    );
  }

  // Time Range Selector: For performance graph
  Widget _buildTimeRangeSelector() {
    List<String> ranges = ['1D', '1W', '1M', '1Y'];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ranges.map((range) {
          return ChoiceChip(
            label: Text(range),
            selected: selectedTimeRange == range,
            onSelected: (selected) {
              if (selected) {
                setState(() => selectedTimeRange = range);
                // Update chart data based on selected range
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '/market_data_service.dart';

class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late MarketDataService marketDataService;
  String liveData = "Waiting for data...";

  @override
  void initState() {
    super.initState();
    marketDataService = MarketDataService();

    // Subscribe to Apple's stock
    marketDataService.subscribeToSymbol("AAPL");

    // Update the UI when data arrives
    marketDataService.listenForUpdates((data) {
      if (data['type'] == 'trade' && data['data'] != null) {
        final trade = data['data'][0];
        final symbol = trade['s'];
        final price = trade['p'];
        final timestamp = DateTime.fromMillisecondsSinceEpoch(trade['t']);
        setState(() {
          liveData = "$symbol: \$${price} at $timestamp";
        });
      }
    });
  }

  @override
  void dispose() {
    marketDataService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Market Data")),
      body: Center(
        child: Text(liveData, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
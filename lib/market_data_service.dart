import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class MarketDataService {
  final String apiKey = 'cv8ig5pr01qqdqh68d60cv8ig5pr01qqdqh68d6g'; // Replace with your Finnhub API key
  late WebSocketChannel channel;

  MarketDataService() {
    // Connect to Finnhub's WebSocket
    channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=$apiKey'),
    );
    print('Connected to Finnhub WebSocket');
  }

  // Subscribe to a stock or crypto symbol (e.g., "AAPL" for Apple)
  void subscribeToSymbol(String symbol) {
    channel.sink.add(jsonEncode({"type": "subscribe", "symbol": symbol}));
    print('Subscribed to $symbol');
  }

  // Listen for updates and pass them to a callback function
  void listenForUpdates(Function(dynamic) onData) {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      onData(data);
    });
  }

  // Clean up by closing the connection
  void dispose() {
    channel.sink.close();
    print('WebSocket connection closed');
  }
}
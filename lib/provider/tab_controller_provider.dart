import 'package:flutter/material.dart';

class TabControllerProvider with ChangeNotifier {
  late final TabController _controller;
  bool _isInitialized = false;
  
  TabController get controller {
    assert(_isInitialized, 'TabController not initialized. Call initialize() first.');
    return _controller;
  }
  
  void initialize(TickerProvider vsync) {
    if (_isInitialized) return;
    
    _controller = TabController(length: 3, vsync: vsync);
    _isInitialized = true;
    // Don't notify listeners here to avoid build phase issues
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
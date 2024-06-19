import 'package:flutter/material.dart';
import 'package:orderplaced/db/models/orderTimer.dart';

class TimerProvider extends ChangeNotifier {
  final Map<String, OrderTimer> _timers = {};

  Map<String, OrderTimer> get timers => _timers;

  void initTimer(String orderId) {
    if(!_timers.containsKey(orderId)) {
      _timers[orderId] = OrderTimer(orderId: orderId);
    }
    _timers[orderId]!.initTimer();
    notifyListeners();
  }

  void stopTimer(String orderId) {
    if(_timers.containsKey(orderId)) {
      _timers[orderId]!.stopTimer();
      notifyListeners();
    }
  }
}
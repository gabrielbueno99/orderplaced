class OrderTimer {
  final String orderId;
  DateTime? startTime;
  bool isRunning;

  OrderTimer({required this.orderId, this.startTime, this.isRunning = false});

  Duration? get elapsedTime {
    if(startTime == null) return null;
    return DateTime.now().difference(startTime!);
  }

  void initTimer() {
    startTime = DateTime.now();
    isRunning = true;
  }

  void stopTimer() {
    isRunning = false;
  }
}
class _TimerScreenState extends State<TimerScreen>
    with WidgetsBindingObserver {

  Timer? _timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();

    // ربط التطبيق بدورة الحياة
    WidgetsBinding.instance.addObserver(this);

    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// مراقبة تغيّر حالة التطبيق
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // التطبيق بالخلفية
      stopTimer();
      debugPrint("⏸ App paused - Timer stopped");
    }

    if (state == AppLifecycleState.resumed) {
      // رجع التطبيق
      startTimer();
      debugPrint("▶ App resumed - Timer started");
    }

    if (state == AppLifecycleState.detached) {
      debugPrint("❌ App closed - Save data here");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Lifecycle Example")),
      body: Center(
        child: Text(
          "Seconds: $seconds",
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

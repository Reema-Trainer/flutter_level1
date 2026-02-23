# App Lifecycle in Flutter

في :contentReference[oaicite:0]{index=0} يوفّر النظام `enum` باسم `AppLifecycleState` يُستخدم لمراقبة **حالات دورة حياة التطبيق** (Application Lifecycle).

---

## AppLifecycleState States

يوجد أربع حالات رئيسية:

| State      | Description |
|------------|-------------|
| `resumed`  | التطبيق ظاهر على الشاشة ويعمل بشكل طبيعي |
| `inactive` | التطبيق موجود لكن غير قابل للتفاعل (مثل استقبال مكالمة أو إشعار) |
| `paused`   | التطبيق انتقل إلى الخلفية |
| `detached` | التطبيق أُغلق أو تم فصله عن واجهة النظام |

---

## When to Use App Lifecycle?

تُستخدم دورة حياة التطبيق عند الحاجة للتعامل مع **سلوك التطبيق ككل** وليس Widget معيّن.

### Real-world Use Cases

- ⏸️ **إيقاف تشغيل الفيديو** عند خروج المستخدم من التطبيق  
- 💾 **حفظ بيانات النموذج تلقائيًا** عند الانتقال للخلفية  
- 🌐 **إيقاف استدعاءات API** غير الضرورية  
- 🔌 **قطع اتصال WebSocket** عند إغلاق التطبيق  
- 🔐 **تسجيل خروج المستخدم** بعد فترة خمول  

---

## Example: Handling App Lifecycle

```dart
class MyScreenState extends State<MyScreen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("App resumed");
        break;

      case AppLifecycleState.inactive:
        print("App inactive");
        break;

      case AppLifecycleState.paused:
        print("App paused - Save data or stop services");
        break;

      case AppLifecycleState.detached:
        print("App detached - Cleanup resources");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

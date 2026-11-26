import 'package:flutter/gestures.dart';
import 'package:otzaria/tabs/utils/tab_swipe_hold.dart';
import 'package:otzaria/widgets/misc/touch_pinch_scale_recognizer.dart';

/// החלקה בין כרטיסיות בלוח מגע, שזוכרת גם את התזוזה האנכית של המחווה.
class TrackpadTabSwipeRecognizer extends HorizontalDragGestureRecognizer {
  TrackpadTabSwipeRecognizer({this.hold, super.debugOwner})
    : super(supportedDevices: const {PointerDeviceKind.trackpad});

  /// מחוות שהתוכן עוד לא ענה עליהן אינן עוברות כרטיסייה.
  final TabSwipeHold? hold;
  int? _pointer;

  /// התזוזה המצטברת של המחווה האחרונה בשני הצירים.
  Offset get pan => _pan;
  Offset _pan = Offset.zero;
  bool _accepted = false;

  /// מבטל מעבר טאב כשקנה המידה משתנה אחרי הזכייה בזירת המחוות.
  void Function()? onPinchAfterAcceptance;

  @override
  void addAllowedPointerPanZoom(PointerPanZoomStartEvent event) {
    _pan = Offset.zero;
    _accepted = false;
    _pointer = event.pointer;
    super.addAllowedPointerPanZoom(event);
  }

  @override
  bool hasSufficientGlobalDistanceToAccept(
    PointerDeviceKind pointerDeviceKind,
    double? deviceTouchSlop,
  ) =>
      !(hold?.holds(_pointer ?? -1) ?? false) &&
      super.hasSufficientGlobalDistanceToAccept(
        pointerDeviceKind,
        deviceTouchSlop,
      );

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerPanZoomUpdateEvent) {
      // צביטה שייכת לתוכן גם כשמרכזה זז לרוחב (#3972).
      if ((event.scale - 1).abs() >
          TouchPinchScaleRecognizer.trackpadScaleSlop) {
        if (_accepted) {
          onPinchAfterAcceptance?.call();
        } else {
          resolve(GestureDisposition.rejected);
        }
        return;
      }
      // localPan כולל גם את הזזת הרכיב; דלתאות שומרות רק את התנועה.
      _pan += event.localPanDelta;
    }
    super.handleEvent(event);
  }

  @override
  void acceptGesture(int pointer) {
    _accepted = true;
    super.acceptGesture(pointer);
  }

  @override
  String get debugDescription => 'trackpad tab swipe';
}

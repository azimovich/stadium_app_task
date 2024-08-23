import "package:flutter/widgets.dart";
import "package:stadium_app_task/src/feature/setting/connetion_controller.dart";

@immutable
class InhertedConnectionNotifair extends InheritedNotifier<ConnetionController> {
  const InhertedConnectionNotifair({
    required final ConnetionController connetionController,
    required super.child,
    super.key,
  }) : super(
          notifier: connetionController,
        );

  static ConnetionController? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<InhertedConnectionNotifair>()?.notifier;
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<InhertedConnectionNotifair>()?.widget;
      return inhW is InhertedConnectionNotifair ? inhW.notifier : null;
    }
  }
}

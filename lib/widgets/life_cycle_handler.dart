import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifeCycleHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifeCycleHandler({
    required this.resumeCallBack
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }
}
import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bloc_observer.dart';

Future<void> bootstrap({
  required FutureOr<Widget> Function() builder,
  FutureOr<void> Function()? init,
}) async {
  await runZonedGuarded(() async {
    BindingBase.debugZoneErrorsAreFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
    await init?.call();
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      return true;
    };

    Bloc.observer = AppBlocObserver();
    final app = await builder();
    runApp(app);
  }, (error, stackTrace) {
    log(error.toString(), stackTrace: stackTrace, name: "BOOTSTRAP");
  });
}

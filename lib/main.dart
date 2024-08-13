import 'package:firebase_core/firebase_core.dart';

import 'app/app.dart';
import 'dependency_injection/dependency_injection.dart';
import 'firebase_options.dart';

void main() {
  bootstrap(
    builder: () => const MainApp(),
    init: () async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      locator();
    },
  );
}

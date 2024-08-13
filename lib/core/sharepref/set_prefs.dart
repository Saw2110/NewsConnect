import '../core.dart';

class SetPrefs {
  static isLogin({required bool value}) async {
    return SharedPref.set(
      key: PrefsConst.isLogin,
      value: value,
      type: PrefType.bool,
    );
  }
}

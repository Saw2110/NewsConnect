import '../core.dart';

class GetPrefs {
  static isLogin() async {
    return SharedPref.get(
      key: PrefsConst.isLogin,
      type: PrefType.bool,
      defaultValue: false,
    );
  }
}

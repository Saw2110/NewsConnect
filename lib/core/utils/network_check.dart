import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return _isConnected(connectivityResult);
  }

  bool _isConnected(List<ConnectivityResult> result) {
    return !result.contains(ConnectivityResult.none);
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class InternetCheckingService with ChangeNotifier{

  final Connectivity _connectivity = Connectivity();

  bool _isConnected = true;


  bool get isConnected => _isConnected;

  Future<void> internetConnectionMonitoring() async{
    _isConnected = await _connectivity.checkConnectivity() != ConnectivityResult.none;
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

}
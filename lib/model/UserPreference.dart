// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

import 'dart:io' show Platform;

class UserPreference extends ChangeNotifier {
  int locationIndex = 0;
  Duration duration = Duration.zero;
  bool isCountDownStart = false;
  final Stream _stream = Stream.periodic(const Duration(seconds: 1));

  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  OpenVPN? vpn;
  bool isVpnInitialized = false;
  VPNStage vpnStage = VPNStage.disconnected;




  void setlocationIndex(int index) {
    locationIndex = index;
    notifyListeners();
  }

  UserPreference() {
    _stream.listen((event) {
      if (isCountDownStart) {
        duration += const Duration(seconds: 1);
        notifyListeners();
      }
    });
    _initVPN();
  }

  Future<void> _initVPN() async {
    vpn = OpenVPN(
      onVpnStatusChanged: (status) => print('Status: $status'),
      onVpnStageChanged: (stage, message) {
        vpnStage = stage;
        notifyListeners();
      },
    );
    if (isMobile) {
      await vpn?.initialize();
    }
    isVpnInitialized = true;
  }

  Future<void> toggleVPN() async {
    if (vpnStage == VPNStage.connected || vpnStage == VPNStage.connecting) {
      await disconnectVPN();
    } else {
      await connectVPN();
    }
  }

  Future<void> connectVPN() async {
    try {
      if (!isVpnInitialized) await _initVPN();

      final config = await rootBundle.loadString('assets/vpnconfig.ovpn');
      await vpn?.connect(
        config,
        'vpnUser',
        certIsRequired: false,
      );
      isCountDownStart = true;
      duration = Duration.zero;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("VPN connect error: $e");
      }
    }
  }

  Future<void> connectWithConfig(String config) async {
    try {
      if (!isVpnInitialized) await _initVPN();

      await vpn?.connect(
        config,
        'vpnUser',
        certIsRequired: false,
      );
      isCountDownStart = true;
      duration = Duration.zero;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("VPN connect error: $e");
      }
    }
  }

  Future<void> disconnectVPN() async {
    vpn?.disconnect();
    isCountDownStart = false;
    duration = Duration.zero;
    notifyListeners();
  }

  void get countDownSwitch {
    isCountDownStart = !isCountDownStart;
    notifyListeners();
  }
}
import 'package:Twitvid/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class NativeAdWidget extends StatelessWidget {
  final NativeAdmobController adController;
  final NativeAdmobType adMobType;
  final String adUnitID;
  NativeAdWidget({
    @required this.adController,
    @required this.adMobType,
    @required this.adUnitID,
  });
  @override
  Widget build(BuildContext context) {
    final Color _textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return NativeAdmob(
      adUnitID: adUnitID,
      loading: Container(),
      error: Text("Failed to load the ad"),
      controller: adController,
      type: adMobType,
      options: NativeAdmobOptions(
        adLabelTextStyle: NativeTextStyle(backgroundColor: kPrimaryBlue),
        callToActionStyle: NativeTextStyle(backgroundColor: kPrimaryBlue),
        bodyTextStyle: NativeTextStyle(color: _textColor),
        advertiserTextStyle: NativeTextStyle(color: _textColor),
        headlineTextStyle: NativeTextStyle(color: _textColor),
      ),
    );
  }
}

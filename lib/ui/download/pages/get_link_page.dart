import 'dart:async';
import 'package:Twitvid/constants/default_values.dart';
import 'package:Twitvid/ui/download/controller/download_controller.dart';
import 'package:Twitvid/ui/widgets/native_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class GetLinkPage extends StatefulWidget {
  @override
  _GetLinkPageState createState() => _GetLinkPageState();
}

class _GetLinkPageState extends State<GetLinkPage> {
  NativeAdmobController _adController = NativeAdmobController();
  TextEditingController _textEditingController = TextEditingController();

  StreamSubscription _intentDataStreamSubscription;
  final _formKey = GlobalKey<FormState>();

  final DownloadController _downloadController = Get.put(DownloadController());

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(
        () {
          _textEditingController.text = value;
        },
      );
    }, onError: (err) {
      print("getLinkStream error: $err");
    });
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        _textEditingController.text = value;
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          autofocus: false,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintText: "Paste your link here",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please paste a twitter video URL here';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 45,
                          child: Obx(
                            () {
                              return RaisedButton(
                                onPressed: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus &&
                                      currentFocus.focusedChild != null) {
                                    FocusManager.instance.primaryFocus
                                        .unfocus();
                                  }
                                  if (_downloadController.isLoading.value) {
                                    return null;
                                  } else {
                                    if (_formKey.currentState.validate()) {
                                      _downloadController.checkVideo(
                                        _textEditingController.text,
                                      );
                                    }
                                  }
                                },
                                child: _downloadController.isLoading.value
                                    ? Container(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Get Video",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(4.0),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 250,
                          child: NativeAdWidget(
                            adController: _adController,
                            adMobType: NativeAdmobType.full,
                            adUnitID: kGetLinkNative,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (!_downloadController.downloading.value) {
              return Container();
            }
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_downloadController.fileName.value),
                        Text(
                          "${_downloadController.progress.value.toStringAsFixed(0)}%",
                        )
                      ],
                    ),
                    subtitle: LinearProgressIndicator(
                      value: _downloadController.progress.value / 100,
                    ),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Image.network(
                        _downloadController.videoData.value.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Feather.x),
                      onPressed: _downloadController.cancelDownloadTask,
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

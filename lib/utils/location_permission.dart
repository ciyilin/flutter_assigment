
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void requestAllPermission({Function? callBack}) async {
  var status = await Permission.location.request();
  if (!status.isGranted) {
    Permission.location.request().then((status) {
      if (status.isGranted) {
        // Permission is granted.
        showToast('Location permission granted');
      } else if (status.isPermanentlyDenied) {
        // The user opted not to grant permission and chose to never be asked again.
        // You must open the app settings.
        openAppSettings();
      } else {
        // Permission is denied (this time not permanently, but another request can be made later).
        showToast('Location permission denied');
      }
    });
  } else {
    bool isLocationGranted = await Permission.location.request().isGranted;
    if (isLocationGranted) {
      if (callBack != null) {
        callBack.call();
      }
    } else {
      if (isLocationGranted == false) {
        // Either the permission was already granted before or the user just granted it.
        Map<Permission, PermissionStatus> statuses = await [
          Permission.location,
        ].request();
        showToast(
            'Permission.location ${statuses[Permission.location]}');
      }
    }
  }
}
void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 4,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black26,
      textColor: Colors.white,
      fontSize: 16.0);
}
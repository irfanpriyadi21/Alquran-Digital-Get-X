import 'package:flutter/cupertino.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

import '../navigator_key.dart';

void sweetAlert(String message){
  SweetAlertV2.show(
    navigatorKey.currentContext!,
    subtitle: message,
    subtitleTextAlign: TextAlign.center,
    style: SweetAlertV2Style.confirm,
  );
}

void sweetAlertSucess(String message, BuildContext context){
  SweetAlertV2.show(
    context,
    subtitle: message,
    subtitleTextAlign: TextAlign.center,
    style: SweetAlertV2Style.success,
  );
}
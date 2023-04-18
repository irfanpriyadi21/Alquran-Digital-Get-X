
import 'dart:convert';

import 'package:alquran_digital/Controller/request.dart';
import 'package:alquran_digital/Model/modelSurah.dart';
import 'package:alquran_digital/Model/modelSurahDetail.dart';
import 'package:alquran_digital/Page/widget/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Page/list_surah_detail.dart';

class SurahController extends GetxController{
  RxBool loading = false.obs;
  Map<String, dynamic>? body;
  RxList<ModelSurah> dataSurah = <ModelSurah>[].obs;
  Rx<ModelSurahDetail> surahDetail = ModelSurahDetail().obs;
  var isDark = false.obs;
  final navigatorKey = GlobalKey<NavigatorState>();

  void changeTheme() => isDark.value = !isDark.value;

  void onInit(){
    super.onInit();
    readSurah();
  }

  void readSurah()async{
    loading.value = true;
    Request request = Request(url: "");
    await request.get().then((value){
      if(value.statusCode == 200){
        List jsonResponse = jsonDecode(value.body);
        dataSurah.value = jsonResponse.map((e) => ModelSurah.fromJson(e)).toList();
      }else{
        sweetAlert("Terjadi Kesalahan !");
      }
    }).catchError((onErrror){
      sweetAlert("Terjadi Kesalahan $onErrror !");
    });
    loading.value = false;
  }

  void toDetailSurah(int? id, String? judul,String? sound){
    readSurahDetail(id!);
    Get.to(()=> ListSurahDetail(id, judul, sound));
  }

  void readSurahDetail(int id)async{
    Request request = Request(url: "/$id");
    await request.get().then((value){
      if(value.statusCode == 200){
        body = jsonDecode(value.body);
        surahDetail.value = ModelSurahDetail.fromJson(body!);
      }else{
        sweetAlert("Terjadi Kesalahan !");
      }
    }).catchError((onErrror, s){
      print(s);
      sweetAlert(onErrror.toString());
    });
  }


}
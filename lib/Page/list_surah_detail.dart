import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/surah_controller.dart';


class ListSurahDetail extends StatelessWidget {
  final int? id;
  final String? judul;
  final String? sound;
  final SurahController surah = Get.put(SurahController());
  ListSurahDetail(this.id, this.judul, this.sound, {Key? key}) : super(key: key);


  Future<void> _pullRefresh()async{
    surah.readSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "$judul",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )
        ),


      ),
      body: SafeArea(
        child: Obx(
              () => RefreshIndicator(
              onRefresh: _pullRefresh,
              child: surah.loading.value
                  ? Center(child:  CircularProgressIndicator(),)
                  : Container(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: surah.surahDetail.value.ayat!.map((e){
                    var index = surah.surahDetail.value.ayat!.indexOf(e);
                    index ++;
                    return GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding:
                        const EdgeInsets.only(bottom: 20, top: 15, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${e.ar}",
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            Html(data: e.tr),
                            Text(

                              "${e.idn}",
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 12
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
          ),
        ),
      ),
    );
  }
}

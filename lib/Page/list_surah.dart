import 'package:alquran_digital/Controller/surah_controller.dart';
import 'package:alquran_digital/Page/list_surah_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListSurah extends StatelessWidget{
  ListSurah({Key? key}) : super(key: key);
  final SurahController surah = Get.put(SurahController());


  Future<void> _pullRefresh()async{
    surah.readSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "AL-Quran",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
        actions: [
         Obx(
             ()=>  IconButton(
               icon: Icon(
                 surah.isDark.value
                     ? Icons.brightness_4
                     : Icons.brightness_5,
                 color: Colors.white,
               ),
               onPressed: ()=> surah.changeTheme(),
             )
         )
        ],

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
                    children: surah.dataSurah.map((e){
                      var index = surah.dataSurah.indexOf(e);
                      index ++;
                      return GestureDetector(
                        onTap: ()=> surah.toDetailSurah(
                            e.nomor,
                            e.namaLatin,
                            e.audio
                        ),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 16),
                          padding:
                          const EdgeInsets.only(bottom: 20, top: 15, left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: surah.isDark.value
                                  ? Colors.grey[300]
                                  : Colors.white,
                              boxShadow: surah.isDark.value
                                  ? [BoxShadow(color: Color(0xff908f8f), blurRadius: 30)]
                                  : [BoxShadow(color: Color(0xFFdcdcdc), blurRadius: 30)],
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/surah.svg',
                                              height: 45),
                                          Text(
                                            "$index",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.namaLatin,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 12
                                            ),
                                          ),
                                          Text(e.arti,
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey  ,
                                                fontSize: 10
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    e.nama,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16
                                    ),
                                  )
                                ],
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

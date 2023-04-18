// To parse this JSON data, do
//
//     final modelSurah = modelSurahFromJson(jsonString);

import 'dart:convert';

List<ModelSurah> modelSurahFromJson(String str) => List<ModelSurah>.from(json.decode(str).map((x) => ModelSurah.fromJson(x)));

String modelSurahToJson(List<ModelSurah> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSurah {
  ModelSurah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
  });

  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  String audio;

  factory ModelSurah.fromJson(Map<String, dynamic> json) => ModelSurah(
    nomor: json["nomor"],
    nama: json["nama"],
    namaLatin: json["nama_latin"],
    jumlahAyat: json["jumlah_ayat"],
    tempatTurun: json["tempat_turun"],
    arti: json["arti"],
    deskripsi: json["deskripsi"],
    audio: json["audio"],
  );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "nama": nama,
    "nama_latin": namaLatin,
    "jumlah_ayat": jumlahAyat,
    "tempat_turun": tempatTurun,
    "arti": arti,
    "deskripsi": deskripsi,
    "audio": audio,
  };
}

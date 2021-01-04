import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'xkcd.g.dart';

class XkcdService = Xkcd with _$XkcdService;

abstract class Xkcd with Store {
  int latestNumber;

  @observable
  bool isMainComicLoading = false;

  @observable
  List<ComicModel> comicsList = [];

  @observable
  ComicModel comic;

  @action
  Future getTodayComic() async {
    isMainComicLoading = true;

    Dio dio = Dio();

    Response res = await dio.get("http://xkcd.com/info.0.json");

    comic = ComicModel(
        comicUrl: res.data['img'],
        comicNumber: res.data['num'],
        comicTitle: res.data['title'],
        comicDate:
            "${res.data['year']}-${res.data['month'].length > 1 ? res.data['month'] : '0' + res.data['month'].toString()}-${res.data['day'].length > 1 ? res.data['day'] : '0' + res.data['day'].toString()}",
        comicAlt: res.data['alt']);
    comicsList.add(comic);
    latestNumber = comic.getComicNumber;
    isMainComicLoading = false;
    return;
  }

  @action
  Future getNumberedComic(int number, String action) async {
    isMainComicLoading = true;
    // print(
    //     " latestNum = $latestNumber  --  number = $number  --  length = ${comicsList.length}");

    if (action == "down") {
      if (latestNumber - number <= (comicsList.length - 1)) {
        // print(" comic already fetched");
        comic = comicsList[latestNumber - number];
      } else {
        // print(" need to fecth comic");
        Dio dio = Dio();

        Response res = await dio.get("http://xkcd.com/info.0.json");

        res = await dio.get("https://xkcd.com/$number/info.0.json");

        comic = ComicModel(
            comicUrl: res.data['img'],
            comicNumber: res.data['num'],
            comicTitle: res.data['title'],
            comicDate:
                "${res.data['year']}-${res.data['month'].length > 1 ? res.data['month'] : '0' + res.data['month'].toString()}-${res.data['day'].length > 1 ? res.data['day'] : '0' + res.data['day'].toString()}",
            comicAlt: res.data['alt']);
        comicsList.add(comic);
      }
    } else if (action == "up") {
      if (number < latestNumber) {
        // print(" comic already fetched");
        comic = comicsList[latestNumber - number - 1];
      }
    }
    isMainComicLoading = false;
    return;
  }

  @action
  Future getRandomComic() async {
    isMainComicLoading = true;

    Dio dio = Dio();

    Response res = await dio.get("http://xkcd.com/info.0.json");

    Random rand = Random();
    int r = rand.nextInt(res.data['num']);
    res = await dio.get("https://xkcd.com/$r/info.0.json");

    comic = ComicModel(
        comicUrl: res.data['img'],
        comicNumber: res.data['num'],
        comicTitle: res.data['title'],
        comicDate:
            "${res.data['year']}-${res.data['month'].length > 1 ? res.data['month'] : '0' + res.data['month'].toString()}-${res.data['day'].length > 1 ? res.data['day'] : '0' + res.data['day'].toString()}",
        comicAlt: res.data['alt']);
    isMainComicLoading = false;
    return;
  }
}

class ComicModel {
  final String comicUrl;
  final String comicTitle;
  final int comicNumber;
  final String comicDate;
  final String comicAlt;

  ComicModel(
      {this.comicUrl,
      this.comicTitle,
      this.comicNumber,
      this.comicDate,
      this.comicAlt});

  String get getComicUrl => comicUrl;
  String get getComicTitle => comicTitle;
  String get getComicDate => comicDate;
  String get getComicAlt => comicAlt;
  int get getComicNumber => comicNumber;
}

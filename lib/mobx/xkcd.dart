import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:mobx/mobx.dart';
import 'package:xkcd_mobx/database/fav_comics.dart';
import 'package:xkcd_mobx/database/fav_comics_dao.dart';
import 'package:xkcd_mobx/mobx/comic_model.dart';

part 'xkcd.g.dart';

class XkcdService = Xkcd with _$XkcdService;

abstract class Xkcd with Store {
  int latestNumber;
  FavComicDao _favComicDao = FavComicDao();

  @observable
  bool isMainComicLoading = false;

  @observable
  bool isComicFavorite = false;

  @observable
  List<ComicModel> comicsList = [];

  @observable
  ComicModel comic;

  @observable
  List<FavComic> favoriteComics = [];

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
    List<FavComic> fetchedFavComics = await _favComicDao.getAllSortedByName();
    isComicFavorite = false;
    for (var i in fetchedFavComics) {
      if (i.comicNumber == comic.getComicNumber) {
        isComicFavorite = true;
        break;
      }
    }
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
    List<FavComic> fetchedFavComics = await _favComicDao.getAllSortedByName();
    isComicFavorite = false;
    for (var i in fetchedFavComics) {
      if (i.comicNumber == comic.getComicNumber) {
        isComicFavorite = true;
        break;
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
    List<FavComic> fetchedFavComics = await _favComicDao.getAllSortedByName();
    isComicFavorite = false;
    for (var i in fetchedFavComics) {
      if (i.comicNumber == comic.getComicNumber) {
        isComicFavorite = true;
        break;
      }
    }
    isMainComicLoading = false;
    return;
  }

  @action
  Future downloadImage() async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage("${comic.getComicUrl}");
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      // var fileName =
      //     await ImageDownloader.findName(imageId);
      // var path =
      //     await ImageDownloader.findPath(imageId);
      // var size =
      //     await ImageDownloader.findByteSize(imageId);
      // var mimeType =
      //     await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
    return;
  }

  @action
  Future shareImage() async {
    try {
      var request =
          await HttpClient().getUrl(Uri.parse('${comic.getComicUrl}'));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('${comic.getComicTitle}', '${comic.getComicNumber}.png',
          bytes, 'image/jpg',
          text:
              '${comic.getComicAlt}                            -->  Shared from xkcd Viewer app by Srihari A 😁');
    } catch (e) {
      print('error: $e');
    }

    return;
  }

  @action
  addFavComic() async {
    List<FavComic> fetchedFavComics = await _favComicDao.getAllSortedByName();
    bool _isExisting = false;
    for (var i in fetchedFavComics) {
      if (i.comicNumber == comic.getComicNumber) {
        _isExisting = true;
        break;
      }
    }
    if (_isExisting) {
      BotToast.showText(
        text: "Comic already added to favorites",
        textStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
        contentColor: Colors.white,
      );
    } else {
      await _favComicDao.insert(
        FavComic(
          comicUrl: comic.getComicUrl,
          comicTitle: comic.getComicTitle,
          comicNumber: comic.getComicNumber,
          comicDate: comic.getComicDate,
          comicAlt: comic.getComicAlt,
        ),
      );
      isComicFavorite = true;
      BotToast.showText(
        text: "Added comic to favorites",
        textStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
        contentColor: Colors.white,
      );
    }
  }

  @action
  Future getFavoriteComics() async {
    isMainComicLoading = true;
    List<FavComic> fetchedFavComics = await _favComicDao.getAllSortedByName();
    isMainComicLoading = false;
    favoriteComics = fetchedFavComics;
    print(" fetched comics: $favoriteComics");
  }
}

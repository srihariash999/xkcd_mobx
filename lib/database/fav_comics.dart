import 'package:meta/meta.dart';

class FavComic {
  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored Fav Comic.
  int id;

  final String comicUrl;
  final String comicTitle;
  final int comicNumber;
  final String comicDate;
  final String comicAlt;

  FavComic({
    @required this.comicUrl,
    @required this.comicTitle,
    @required this.comicNumber,
    @required this.comicDate,
    @required this.comicAlt,
  });

  Map<String, dynamic> toMap() {
    return {
      'comicUrl': comicUrl,
      'comicTitle': comicTitle,
      'comicNumber': comicNumber,
      'comicDate': comicDate,
      'comicAlt': comicAlt,
    };
  }

  static FavComic fromMap(Map<String, dynamic> map) {
    return FavComic(
      comicUrl: map['comicUrl'],
      comicTitle: map['comicTitle'],
      comicNumber: map['comicNumber'],
      comicDate: map['comicDate'],
      comicAlt: map['comicAlt'],
    );
  }
}

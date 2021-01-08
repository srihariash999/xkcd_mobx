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
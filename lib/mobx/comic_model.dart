class ComicModel {
  final int comicId;
  final String comicUrl;
  final String comicTitle;
  final int comicNumber;
  final String comicDate;
  final String comicAlt;

  int _comicId;

  ComicModel(
      {this.comicUrl,
      this.comicTitle,
      this.comicNumber,
      this.comicDate,
      this.comicAlt,
      this.comicId})
      : _comicId = comicId;

  String get getComicUrl => comicUrl;
  String get getComicTitle => comicTitle;
  String get getComicDate => comicDate;
  String get getComicAlt => comicAlt;
  int get getComicNumber => comicNumber;
  int get getComicId => _comicId;

  setComicId(int x) => _comicId = x;
}

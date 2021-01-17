// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xkcd.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$XkcdService on Xkcd, Store {
  final _$isMainComicLoadingAtom = Atom(name: 'Xkcd.isMainComicLoading');

  @override
  bool get isMainComicLoading {
    _$isMainComicLoadingAtom.reportRead();
    return super.isMainComicLoading;
  }

  @override
  set isMainComicLoading(bool value) {
    _$isMainComicLoadingAtom.reportWrite(value, super.isMainComicLoading, () {
      super.isMainComicLoading = value;
    });
  }

  final _$isComicFavoriteAtom = Atom(name: 'Xkcd.isComicFavorite');

  @override
  bool get isComicFavorite {
    _$isComicFavoriteAtom.reportRead();
    return super.isComicFavorite;
  }

  @override
  set isComicFavorite(bool value) {
    _$isComicFavoriteAtom.reportWrite(value, super.isComicFavorite, () {
      super.isComicFavorite = value;
    });
  }

  final _$comicsListAtom = Atom(name: 'Xkcd.comicsList');

  @override
  List<ComicModel> get comicsList {
    _$comicsListAtom.reportRead();
    return super.comicsList;
  }

  @override
  set comicsList(List<ComicModel> value) {
    _$comicsListAtom.reportWrite(value, super.comicsList, () {
      super.comicsList = value;
    });
  }

  final _$comicAtom = Atom(name: 'Xkcd.comic');

  @override
  ComicModel get comic {
    _$comicAtom.reportRead();
    return super.comic;
  }

  @override
  set comic(ComicModel value) {
    _$comicAtom.reportWrite(value, super.comic, () {
      super.comic = value;
    });
  }

  final _$favoriteComicsAtom = Atom(name: 'Xkcd.favoriteComics');

  @override
  List<FavComic> get favoriteComics {
    _$favoriteComicsAtom.reportRead();
    return super.favoriteComics;
  }

  @override
  set favoriteComics(List<FavComic> value) {
    _$favoriteComicsAtom.reportWrite(value, super.favoriteComics, () {
      super.favoriteComics = value;
    });
  }

  final _$getTodayComicAsyncAction = AsyncAction('Xkcd.getTodayComic');

  @override
  Future<dynamic> getTodayComic(Function fun) {
    return _$getTodayComicAsyncAction.run(() => super.getTodayComic(fun));
  }

  final _$getNumberedComicAsyncAction = AsyncAction('Xkcd.getNumberedComic');

  @override
  Future<dynamic> getNumberedComic(int number, String action) {
    return _$getNumberedComicAsyncAction
        .run(() => super.getNumberedComic(number, action));
  }

  final _$getRandomComicAsyncAction = AsyncAction('Xkcd.getRandomComic');

  @override
  Future<dynamic> getRandomComic() {
    return _$getRandomComicAsyncAction.run(() => super.getRandomComic());
  }

  final _$downloadImageAsyncAction = AsyncAction('Xkcd.downloadImage');

  @override
  Future<dynamic> downloadImage() {
    return _$downloadImageAsyncAction.run(() => super.downloadImage());
  }

  final _$shareImageAsyncAction = AsyncAction('Xkcd.shareImage');

  @override
  Future<dynamic> shareImage() {
    return _$shareImageAsyncAction.run(() => super.shareImage());
  }

  final _$addFavComicAsyncAction = AsyncAction('Xkcd.addFavComic');

  @override
  Future addFavComic() {
    return _$addFavComicAsyncAction.run(() => super.addFavComic());
  }

  final _$getFavoriteComicsAsyncAction = AsyncAction('Xkcd.getFavoriteComics');

  @override
  Future<dynamic> getFavoriteComics() {
    return _$getFavoriteComicsAsyncAction.run(() => super.getFavoriteComics());
  }

  final _$favRemoveActionAsyncAction = AsyncAction('Xkcd.favRemoveAction');

  @override
  Future<dynamic> favRemoveAction(FavComic fc) {
    return _$favRemoveActionAsyncAction.run(() => super.favRemoveAction(fc));
  }

  @override
  String toString() {
    return '''
isMainComicLoading: ${isMainComicLoading},
isComicFavorite: ${isComicFavorite},
comicsList: ${comicsList},
comic: ${comic},
favoriteComics: ${favoriteComics}
    ''';
  }
}

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

  final _$getTodayComicAsyncAction = AsyncAction('Xkcd.getTodayComic');

  @override
  Future<dynamic> getTodayComic() {
    return _$getTodayComicAsyncAction.run(() => super.getTodayComic());
  }

  final _$getRandomComicAsyncAction = AsyncAction('Xkcd.getRandomComic');

  @override
  Future<dynamic> getRandomComic() {
    return _$getRandomComicAsyncAction.run(() => super.getRandomComic());
  }

  @override
  String toString() {
    return '''
isMainComicLoading: ${isMainComicLoading},
comicsList: ${comicsList},
comic: ${comic}
    ''';
  }
}

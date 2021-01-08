import 'package:sembast/sembast.dart';
import 'package:xkcd_mobx/database/app_database.dart';
import 'package:xkcd_mobx/database/fav_comics.dart';

class FavComicDao {
  static const String FAVCOMIC_STORE_NAME = 'favcomics';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _favcomicStore = intMapStoreFactory.store(FAVCOMIC_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(FavComic favComic) async {
    await _favcomicStore.add(await _db, favComic.toMap());
  }

  Future update(FavComic favComic) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(favComic.id));
    await _favcomicStore.update(
      await _db,
      favComic.toMap(),
      finder: finder,
    );
  }

  Future delete(FavComic favComic) async {
    final finder = Finder(filter: Filter.byKey(favComic.id));
    await _favcomicStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<FavComic>> getAllSortedByName() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('comicNumber'),
    ]);

    final recordSnapshots = await _favcomicStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final favComic = FavComic.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      favComic.id = snapshot.key;
      return favComic;
    }).toList();
  }
}
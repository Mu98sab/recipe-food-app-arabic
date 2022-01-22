import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe/Model/recipe.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';


class TypeState{

  TypeState() {
    final Database db = Database();
    // print("stat listening to queries");
    eventStream.listen(
      (event) async{
        // print("EVENT ACTION");
        typeSink.add(await db.getRecipe(query: event,));
      }
    );
  }

  final StreamController<List<Recipe>?> _typeStreamController =  BehaviorSubject();
  StreamSink<List<Recipe>?> get typeSink => _typeStreamController.sink;
  Stream<List<Recipe>?> get typeStream => _typeStreamController.stream;


  final StreamController<RecipeQuery> _eventStreamController = BehaviorSubject();
  StreamSink<RecipeQuery> get eventSink => _eventStreamController.sink;
  Stream<RecipeQuery> get eventStream => _eventStreamController.stream;

  void disposeStream() {
    _typeStreamController.close();
    _eventStreamController.close();
  }

}



// void addStream() {
//   _typeStreamController.addStream()
// }






enum RecipeQuery{
  mostPopular,
  newest,
  mostSaved,
  all,
  sweet,
  drinks,
  meat,
  chicken,
  seaFood,
  pasta,
  bread,
  sauce,
  rice,
  snacks,
  more,
  /* Also add all the categories */
  /* Also add the three difficult types*/
}

extension on Query<Recipe> {
  /// Create a firebase query from a [RecipeQuery]
  Query<Recipe> queryBy(RecipeQuery query) {
    switch (query) {
      case RecipeQuery.newest:
        return where(
          'date',
          isGreaterThan: DateTime.now().subtract(
            Duration(days: 30),
          ),
        ).orderBy("date", descending: true, ).limit(30);

      case RecipeQuery.mostPopular:
        return orderBy("visit", descending: true);

      case RecipeQuery.mostSaved:
        return orderBy("savedNo", descending: true);

      case RecipeQuery.all:
        return where("name");

      case RecipeQuery.sweet: 
        return where("type", isEqualTo: "حلويات");

      case RecipeQuery.drinks: 
        return where("type", isEqualTo: "مشروبات");
      
      case RecipeQuery.meat:
        return where("type", isEqualTo: "لحوم");

      case RecipeQuery.chicken:
        return where("type", isEqualTo: "دجاج");
      
      case RecipeQuery.seaFood:
        return where("type", isEqualTo: "مأكولات بحرية");
      
      case RecipeQuery.pasta:
        return where("type", isEqualTo: "معكرونة");

      case RecipeQuery.bread:
        return where("type", isEqualTo: "معجنات");

      case RecipeQuery.sauce:
        return where("type", isEqualTo: "صلصات");

      case RecipeQuery.rice:
        return where("type", isEqualTo: "عيش");
      
      case RecipeQuery.snacks:
        return where("type", isEqualTo: "وجبات خفيفة");
      
      case RecipeQuery.more:
        return where("type", isEqualTo: "أخرى");
    }
  }
}

class Database {
  final CollectionReference<Recipe> _recipesRef = FirebaseFirestore.instance
    .collection("Recipe")
    .withConverter<Recipe>(
        fromFirestore: (snapshots, _) => Recipe.fromJson(snapshots.data()!, snapshots.id),
        toFirestore: (recipe, _) => recipe.toJson());

  final CollectionReference<RecipeCook> _cookingRef = FirebaseFirestore.instance
    .collection("SubRecipe")
    .withConverter<RecipeCook>(
      fromFirestore: (snapshot, _) => RecipeCook.fromJson(snapshot.data()!),
      toFirestore: (cook, _) => cook.toJson(),
    );

  final FirebaseStorage _storage = FirebaseStorage.instance;


  late QuerySnapshot recipes;

  Future<List<Recipe>?> getRecipe({RecipeQuery? query}) async{
    try {
      QuerySnapshot<Recipe> recipes = 
        query == null ? await _recipesRef.get() 
        : await _recipesRef.queryBy(query).get();

      return recipes.docs.map((doc) => doc.data()).toList();
    }
    catch (err) {
      print(err.toString());
    }
    return null;
      
    // print(recipes.docs[0].data());
    // Timestamp time = recipes.docs[0]['date'];
    // print(
    //   DateTime.fromMillisecondsSinceEpoch(
    //     time.millisecondsSinceEpoch
    //   )
    // );

  }

  Future<RecipeCook?> getCook(String id) async{
    try {

      return await _cookingRef.doc(id).get().then((val) => val.data());
    
    }
    catch (err) {
      print("ERROR");
      print(err.toString());
    }
    return null;
  }

  Future<String?> getImg(String imgPath) async{
    try{
      return await _storage.ref().child(imgPath).getDownloadURL();
    }
    catch(err){
      print("My ERROR");
      print(err.toString());
    }
    return null;
  }

  Future<bool?> incViews(String? id, int? pre) async{
    try {
      DocumentReference<Recipe> doc = _recipesRef.doc(id);
      await doc.update({"visit": (await (doc.get().then((value) => (value.data()!.visit))))! + 1 });
    }
    catch(err) {
      print("MY ERROR");
      print(err.toString());
      return false;
    }
    return true;
  }


}


 

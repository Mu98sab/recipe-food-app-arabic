import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Recipe {

  const Recipe({
    @required this.name,
    @required this.type,
    @required this.difficulty,
    @required this.img,
    @required this.person,
    @required this.time,
    @required this.visit,
    @required this.date,
    @required this.subRecipe,
    @required this.savedNo,
    @required this.rate,
    @required this.id,
  });

  
  Recipe.fromJson(Map<String, Object?> json, String? id)
    : this(
      name : json['name'] as String?,
      type : json['type']! as String?,
      img : json['img']! as String?,
      difficulty : json['difficulty']! as String?,
      person : json['person']! as int?,
      time : json['time']! as int?,
      visit : json['visit']! as int?, 
      savedNo : json['savedNo']! as int?,
      rate : json['rate']! as num?,
      date : DateTime.fromMillisecondsSinceEpoch((json['date']! as Timestamp?)!.millisecondsSinceEpoch),
      // subRecipe : (json['subRecipe']! as List).cast<RecipeCook>(),
      subRecipe: (json['subRecipe']! as List).cast<String>(),
      id: id,
    );


  final String? name, img, difficulty, type;
  final int? person, time, visit, savedNo;
  final num? rate;
  final DateTime? date;
  final String? id;

  // final List<RecipeCook>? subRecipe;
  final List<String>? subRecipe;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'type': type,
      'difficulty': difficulty,
      'img': img,
      'time': time,
      'person': person,
      'visit': visit,
      'subRecipe': subRecipe,
      'date': date,
      'rate': rate,
      'savedNo': savedNo
    };
  }
}

class RecipeCook {
  
  const RecipeCook ({
    @required this.name,
    @required this.ingredientName,
    @required this.ingredientMag,
    @required this.steps,
    
  });
  
  RecipeCook.fromJson(Map<String, Object?> json): this(
    name : json['name'] as String?,
    ingredientName: (json['ingredient_name'] as List).cast<String>(),
    ingredientMag: (json['ingredient_amount'] as List).cast<String>(),
    steps: (json["steps"] as List).cast<String>(),
  );


  final String? name;
  final List<String>? ingredientName;
  final List<String>? ingredientMag;
  final List<String>? steps;
  

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "ingredient_name": ingredientName,
      "ingredient_amount": ingredientMag,
      "steps": steps,
    };
  }


}
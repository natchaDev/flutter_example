// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_quiz_app/data/local_db/person_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/person_entity.dart';


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Person])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
}
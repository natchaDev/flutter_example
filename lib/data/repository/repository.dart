
import 'package:flutter_quiz_app/data/local_db/database.dart';

import '../../models/person_entity.dart';
import '../../models/priority.dart';
import '../../models/to_do.dart';

const _delay = Duration(milliseconds: 800);

var _priority = [
  Priority(index: 1, title: 'Highest', checked: false),
  Priority(index: 2, title: 'Medium', checked: false),
  Priority(index: 3, title: 'Low', checked: false),
];

class Repository {
  final _items = <ToDo>[];
  final _priorityList = _priority;

  Future<List<Priority>> loadPriority() => Future.delayed(_delay, () => _priorityList);

  Future<List<ToDo>> loadToDoList() => Future.delayed(_delay, () => _items);

  Future<List<Person>> loadPersonList()async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final personDao = database.personDao;
    return await personDao.findAllPersons();
  }

  void addItem(ToDo item) => _items.add(item);

  void selectPriority(Priority? priority) => _priorityList.map((item) {
    item.checked = item.index == priority?.index;
    return item;
  }).toList();

  void checked(ToDo toDo) => _items.map((item) {
        if (item.index == toDo.index) {
          item.checked = !item.checked;
        }
        return item;
      }).toList();

  void removeItem(ToDo toDo) => _items.removeWhere((item) {
    if (item.index == toDo.index) {
      return true;
    }
    return false;
  });

  Future<bool> createPerson(Person person) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final personDao = database.personDao;
      await personDao.insertPerson(person);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

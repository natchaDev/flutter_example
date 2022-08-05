import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/screens/person/create_person/create_person_page.dart';
import 'screens/calculator/calculator_page.dart';
import 'screens/to_do_list/to_do_list_page.dart';
import 'package:flutter_quiz_app/simple_blog_observer.dart';

import 'app.dart';
import 'data/repository/repository.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(App(repository: Repository())),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        repository: context.read<Repository>(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title, required this.repository})
      : super(key: key);
  final Repository repository;
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _textButton(String text, Function onPressed) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        onPressed.call();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _textButton('Quiz 1: To Do List', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToDoListPage(
                    repository: widget.repository,
                  ),
                ),
              );
            }),
            _textButton('Quiz 2: Calculator', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatorPage()),
              );
            }),
            _textButton('Quiz 3: Person Detail', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePersonPage(
                    repository: widget.repository,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

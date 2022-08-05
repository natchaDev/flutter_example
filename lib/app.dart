import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/repository.dart';
import 'main.dart';

class App extends MaterialApp {
  App({Key? key, required Repository repository})
      : super(
  home: RepositoryProvider.value(
  value: repository,
  child: MyHomePage(repository: repository,),
  ),
  );
}
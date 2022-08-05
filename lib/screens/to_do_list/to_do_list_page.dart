import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/screens/to_do_list/to_do_list_bloc.dart';
import 'package:flutter_quiz_app/screens/to_do_list/to_do_list_event.dart';
import 'package:flutter_quiz_app/screens/to_do_list/to_do_list_state.dart';

import 'package:provider/provider.dart';

import '../../data/repository/repository.dart';
import '../../models/priority.dart';
import '../../models/to_do.dart';

class ToDoListPage extends StatelessWidget {
  final Repository repository;

  const ToDoListPage({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ToDoListBloc(
        repository: this.repository,
      )..add(ToDoListStarted()),
      child: ToDoListView(),
    );
  }
}

class ToDoListView extends StatelessWidget {
  final TextEditingController _controllerNumber1 = TextEditingController();
  Priority? _priority;

  ToDoListView({Key? key}) : super(key: key);

  Widget _titleContent(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 20),
      child: Text(
        title,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            _titleContent('Input Todo'),
            TextField(
              controller: _controllerNumber1,
              decoration: InputDecoration(
                labelText: 'To Do',
              ),
              keyboardType: TextInputType.text,
            ),
            _titleContent('Select Piority'),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 65,
              margin: EdgeInsets.only(top: 12, bottom: 12),
              child: _priorityContent(context),
            ),
            InkWell(
              child: Text(
                "Add Data",
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
              onTap: () {
                context.read<ToDoListBloc>().add(ToDoListItemAdded(ToDo(
                      index: Random().nextInt(100),
                      title: _controllerNumber1.text,
                      priority: _priority,
                      checked: false,
                    )));
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _priorityContent(BuildContext context) {
    return BlocBuilder<ToDoListBloc, ToDoListState>(
      buildWhen: (pre, curr) {
        return curr is PriorityLoaded;
      },
      builder: (context, state) {
        if (state is PriorityLoaded) {
          return ListView.separated(
            itemCount: state.priorityList?.length ?? 0,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final item = state.priorityList?[index];
              return Container(
                margin: EdgeInsets.only(right: 12),
                child: Material(
                  color: item?.checked ?? false
                      ? Colors.green
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        item?.title ?? '',
                        style: TextStyle(
                          decoration: item?.checked ?? false
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
                    ),
                    onTap: () {
                      context
                          .read<ToDoListBloc>()
                          .add(ToDoListPrioritySelected(item));
                      _priority = item;
                    },
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _listView(BuildContext context) {
    return BlocBuilder<ToDoListBloc, ToDoListState>(
      buildWhen: (pre, curr) {
        return curr is ToDoListLoaded;
      },
      builder: (context, state) {
        if (state is ToDoListLoaded) {
          return ListView.separated(
            itemCount: state.toDoList?.length ?? 0,
            separatorBuilder: (_, __) => Divider(
              color: Theme.of(context).primaryColor,
            ),
            itemBuilder: (context, index) {
              final item = state.toDoList?[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(
                        item?.checked ?? false
                            ? Icons.check_circle_outline
                            : Icons.check,
                        color:
                            item?.checked ?? false ? Colors.green : Colors.grey,
                      ),
                      onTap: () {
                        context
                            .read<ToDoListBloc>()
                            .add(ToDoListItemChecked(item!));
                      },
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item?.title ?? '',
                                style: Theme.of(context).textTheme.bodyText1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Visibility(
                              visible: item?.priority != null,
                              child: Container(
                                margin: EdgeInsets.only(left: 12, right: 16),
                                child: Text(
                                  item?.priority?.title ?? '',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        context
                            .read<ToDoListBloc>()
                            .add(ToDoListItemRemoved(item!));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Do List')),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              _header(context),
              SizedBox(
                height: 20,
              ),
              Text(
                "TO DO LIST",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: _listView(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

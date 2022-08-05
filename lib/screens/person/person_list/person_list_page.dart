import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/models/person_entity.dart';
import 'package:flutter_quiz_app/screens/person/person_list/person_list_bloc.dart';
import 'package:flutter_quiz_app/screens/person/person_list/person_list_event.dart';
import 'package:flutter_quiz_app/screens/person/person_list/person_list_state.dart';

import '../../../data/repository/repository.dart';
import '../components/person_detail_card.dart';
import '../person_detail/person_detail_page.dart';

class PersonListPage extends StatelessWidget {
  final Repository repository;

  const PersonListPage({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonListBloc(
        repository: this.repository,
      )..add(PersonListStarted()),
      child: PersonListView(),
    );
  }
}

class PersonListView extends StatelessWidget {
  PersonListView({Key? key}) : super(key: key);

  Widget _listView(BuildContext context) {
    return BlocBuilder<PersonListBloc, PersonListState>(
      buildWhen: (pre, curr) {
        return curr is PersonListLoaded;
      },
      builder: (context, state) {
        if (state is PersonListLoading) {
          return CupertinoActivityIndicator();
        }
        if (state is PersonListLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.personList?.length ?? 0,
            separatorBuilder: (_, __) => Divider(
              color: Theme.of(context).primaryColor,
            ),
            itemBuilder: (context, index) {
              final person = state.personList?[index];
              if (person == null) return Container();
              return InkWell(
                child: PersonDetailCard(person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonDetailPage(
                        person: person,
                      ),
                    ),
                  );
                },
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
      appBar: AppBar(title: const Text('Person List')),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Text(
                "Person LIST",
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

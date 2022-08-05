import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/person_entity.dart';
import '../components/person_detail_card.dart';

class PersonDetailPage extends StatelessWidget {
  final Person person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersonDetailView(person: person);
  }
}

class PersonDetailView extends StatelessWidget {
  final Person person;

  PersonDetailView({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person Detail')),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Text(
                "Person Detail",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              PersonDetailCard(person),
            ],
          ),
        ),
      ),
    );
  }
}

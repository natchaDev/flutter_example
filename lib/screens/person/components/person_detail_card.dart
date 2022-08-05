import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/person_entity.dart';

class PersonDetailCard extends StatelessWidget {
  final Person person;

  PersonDetailCard(this.person);

  Widget _textContent({
    required String title,
    String? content,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return Row(
      children: [
        Text(
          '$title : ',
          style: titleTextStyle,
        ),
        Expanded(
            child: Text(
          content ?? '-',
          style: contentTextStyle,
        ))
      ],
    );
  }

  Widget _informationContent(
    Person person, {
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _textContent(
                title: 'First Name',
                content: person.firstName,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
            Expanded(
              child: _textContent(
                title: 'Last Name',
                content: person.lastName,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        _textContent(
          title: 'Email',
          content: person.email,
          titleTextStyle: titleTextStyle,
          contentTextStyle: contentTextStyle,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: _textContent(
                  title: 'Phone',
                  content: person.phoneNumber,
                  titleTextStyle: titleTextStyle,
                  contentTextStyle: contentTextStyle,
                )
            ),
            Expanded(
              child: _textContent(
                title: 'Age',
                content: person.age,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _addressContent(
    Person person, {
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _textContent(
                title: 'Address',
                content: person.address,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
            Expanded(
              child: _textContent(
                title: 'District',
                content: person.district,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _textContent(
                title: 'Sub District',
                content: person.subDistrict,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
            Expanded(
              child: _textContent(
                title: 'Province',
                content: person.province,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _textContent(
                title: 'Country',
                content: person.country,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
            Expanded(
              child: _textContent(
                title: 'Zip Code',
                content: person.zipCode,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _content(BuildContext context, Person person) {
    TextStyle? titleTextStyle = Theme.of(context).textTheme.bodyLarge;
    TextStyle? contentTextStyle = Theme.of(context).textTheme.bodySmall;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 14),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Informations",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              _informationContent(
                person,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 14),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Addres",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              _addressContent(
                person,
                titleTextStyle: titleTextStyle,
                contentTextStyle: contentTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _content(context, person);
  }
}

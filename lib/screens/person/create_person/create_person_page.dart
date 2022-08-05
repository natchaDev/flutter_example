import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/models/person_entity.dart';
import 'package:flutter_quiz_app/screens/person/person_detail/person_detail_page.dart';
import 'package:flutter_quiz_app/screens/person/person_list/person_list_page.dart';
import 'dart:math';
import '../../../data/repository/repository.dart';
import 'create_person_state.dart';
import 'create_person_bloc.dart';

class CreatePersonPage extends StatelessWidget {
  final Repository repository;

  const CreatePersonPage({Key? key, required this.repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StepCubit>(
      create: (_) => StepCubit(
        repository: this.repository,
        stepperLength: 2,
      ),
      child: CreatePersonView(repository: repository),
    );
  }
}

class CreatePersonView extends StatelessWidget {
  final Repository repository;

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerSubDistrict = TextEditingController();
  final TextEditingController _controllerProvince = TextEditingController();
  final TextEditingController _controllerCountry = TextEditingController();
  final TextEditingController _controllerZipCode = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();

  Person? _newPerson;

  CreatePersonView({Key? key, required this.repository}) : super(key: key);

  Step _step({
    required StepState stepState,
    required bool isActive,
    required String title,
    required Widget child,
  }) {
    return Step(
      state: stepState,
      isActive: isActive,
      title: Text(title),
      content: child,
    );
  }

  Widget _textField(TextEditingController controller, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }

  List<Step> stepList(int activeStepIndex) => [
        _step(
          stepState:
              activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: activeStepIndex >= 0,
          title: "Informations",
          child: _informationContent(),
        ),
        _step(
          stepState:
              activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: activeStepIndex >= 1,
          title: "Address",
          child: _addressContent(),
        ),
      ];

  Widget _informationContent() {
    return Column(
      children: [
        _textField(_controllerFirstName, 'First Name'),
        _textField(_controllerLastName, 'Last Name'),
        _textField(_controllerAge, 'Age'),
        _textField(_controllerEmail, 'Email'),
        _textField(_controllerPhoneNumber, 'Phone Number'),
      ],
    );
  }

  Widget _addressContent() {
    return Column(
      children: [
        _textField(_controllerAddress, 'Address'),
        _textField(_controllerDistrict, 'District'),
        _textField(_controllerSubDistrict, 'Sub District'),
        _textField(_controllerProvince, 'Province'),
        _textField(_controllerCountry, 'Country'),
        _textField(_controllerZipCode, 'Zip Code'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Person')),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<StepCubit, CreatePersonState>(
                  builder: (context, state) {
                    final isLastStep = state.activeStepperIndex ==
                        stepList(state.activeStepperIndex).length - 1;
                    return Stepper(
                      type: StepperType.vertical,
                      currentStep: state.activeStepperIndex,
                      steps: stepList(state.activeStepperIndex),
                      onStepContinue: () {
                        if (isLastStep) {
                          _newPerson = Person(
                            Random().nextInt(100),
                            firstName: _controllerFirstName.text,
                            lastName: _controllerLastName.text,
                            email: _controllerEmail.text,
                            age: _controllerAge.text,
                            address: _controllerAddress.text,
                            district: _controllerDistrict.text,
                            subDistrict: _controllerSubDistrict.text,
                            province: _controllerProvince.text,
                            country: _controllerCountry.text,
                            phoneNumber: _controllerPhoneNumber.text,
                            zipCode: _controllerZipCode.text,
                          );
                        }
                        context.read<StepCubit>().stepContinued(
                            person: isLastStep ? _newPerson : null);
                      },
                      onStepCancel: context.read<StepCubit>().stepCancelled,
                      onStepTapped: context.read<StepCubit>().stepTapped,
                      controlsBuilder: (context, controlsDetails) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: controlsDetails.onStepContinue,
                                    child: Text(isLastStep ? 'Submit' : 'Next'),
                                  ),
                                ),
                                Visibility(
                                  visible: state.activeStepperIndex > 0,
                                  child: Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: ElevatedButton(
                                        onPressed: controlsDetails.onStepCancel,
                                        child: const Text('Back'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: isLastStep && _newPerson != null,
                                  child: Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_newPerson == null) return;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PersonDetailPage(
                                                person: _newPerson!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text('View'),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isLastStep,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PersonListPage(
                                              repository: repository,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('View All'),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

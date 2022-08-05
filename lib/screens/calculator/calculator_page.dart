import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calculator_bloc.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorBloc(),
      child: CalculatorView(),
    );
  }
}

class CalculatorView extends StatelessWidget {
  final TextEditingController _controllerNumber1 = TextEditingController();
  final TextEditingController _controllerNumber2 = TextEditingController();

  CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              TextField(
                controller: _controllerNumber1,
                decoration: InputDecoration(
                  labelText: 'Number 1',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _controllerNumber2,
                decoration: InputDecoration(
                  labelText: 'Number 2',
                ),
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: EdgeInsets.only(top: 18, bottom: 18),
                child: Row(
                  children: [
                    InkWell(
                      child: Text("plus"),
                      onTap: () {
                        context.read<CalculatorBloc>().add(CalculatorEvent(
                          Operation.plus,
                          _controllerNumber1.text,
                          _controllerNumber2.text,
                        ));
                      },
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      child: Text("minus"),
                      onTap: () {
                        context.read<CalculatorBloc>().add(CalculatorEvent(
                          Operation.minus,
                          _controllerNumber1.text,
                          _controllerNumber2.text,
                        ));
                      },
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      child: Text("multiple"),
                      onTap: () {
                        context.read<CalculatorBloc>().add(CalculatorEvent(
                          Operation.multiple,
                          _controllerNumber1.text,
                          _controllerNumber2.text,
                        ));
                      },
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      child: Text("divide"),
                      onTap: () {
                        context.read<CalculatorBloc>().add(CalculatorEvent(
                          Operation.divide,
                          _controllerNumber1.text,
                          _controllerNumber2.text,
                        ));
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<CalculatorBloc, int>(
                builder: (context, count) {
                  return Text('$count',
                      style: Theme.of(context).textTheme.headline1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:clean_arch_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({super.key});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final controller = TextEditingController(text: "");
  String inputString = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                inputString = value;
              });
            },
            onSubmitted: (_) {
              _dispatchConcrete();
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Input a number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: _dispatchConcrete,
                  child: const Text('Get trivia')),
              ElevatedButton(
                  onPressed: () {
                    context.read<NumberTriviaBloc>().add(
                          GetTriviaForRandomNumber(),
                        );
                  },
                  child: const Text('Random!')),
            ],
          )
        ],
      ),
    );
  }

  void _dispatchConcrete() {
    controller.clear();
    context.read<NumberTriviaBloc>().add(
          GetTriviaForConcreteNumber(inputString),
        );
  }
}

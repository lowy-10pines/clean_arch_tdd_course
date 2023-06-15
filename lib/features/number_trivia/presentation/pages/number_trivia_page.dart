import 'package:clean_arch_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/presentation/widgets/input_widget.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/presentation/widgets/output_widget.dart';
import 'package:clean_arch_tdd_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (_) => getIt<NumberTriviaBloc>(),
        child: const SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutputWidget(),
              InputWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

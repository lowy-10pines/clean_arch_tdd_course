import 'package:clean_arch_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutputWidget extends StatelessWidget {
  const OutputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        final children = switch (state) {
          Empty() => [
              Text(
                'Start searching!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          Loading() => [
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            ],
          Errored() => [
              Text(
                'There was an error',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(state.message),
            ],
          Loaded() => [
              Text(
                "${state.trivia.number}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(
                state.trivia.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
        };
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: children,
          ),
        );
      },
    );
  }
}

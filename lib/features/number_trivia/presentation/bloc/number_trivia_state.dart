part of 'number_trivia_bloc.dart';

@immutable
sealed class NumberTriviaState {}

class Empty extends NumberTriviaState {
  @override
  bool operator ==(Object other) {
    return other is Empty;
  }

  @override
  int get hashCode => 1 + super.hashCode;
}

class Loading extends NumberTriviaState {
  @override
  bool operator ==(Object other) {
    return other is Loading;
  }

  @override
  int get hashCode => 2 + super.hashCode;
}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded(this.trivia);

  @override
  bool operator ==(Object other) {
    return other is Loaded && trivia == other.trivia;
  }

  @override
  int get hashCode => 3 + trivia.hashCode + super.hashCode;
}

class Errored extends NumberTriviaState {
  final String message;

  Errored(this.message);

  @override
  bool operator ==(Object other) {
    return other is Errored && message == other.message;
  }

  @override
  int get hashCode => 4 + message.hashCode + super.hashCode;
}

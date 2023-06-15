import 'package:clean_arch_tdd_course/core/either.dart';
import 'package:clean_arch_tdd_course/core/error/failures.dart';
import 'package:clean_arch_tdd_course/core/util/input_converter.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetConcreteNumberTrivia>(),
  MockSpec<GetRandomNumberTrivia>(),
  MockSpec<InputConverter>(),
])
void main() {
  late NumberTriviaBloc bloc;
  late MockInputConverter mockInputConverter;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;

  setUp(() {
    mockInputConverter = MockInputConverter();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    bloc = NumberTriviaBloc(
        inputConverter: mockInputConverter,
        random: mockGetRandomNumberTrivia,
        concrete: mockGetConcreteNumberTrivia);
  });

  test('initial state should be Empty', () {
    expect(bloc.state, Empty());
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia("Test trivia", 1);

    setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
    }

    blocTest(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      setUp: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      verify: (_) {
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    blocTest(
      'emits Errored when the input is invalid',
      setUp: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Errored(invalidInputMessage),
      ],
    );

    blocTest(
      'should get data from the Concrete use case',
      setUp: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      verify: (bloc) {
        verify(mockGetConcreteNumberTrivia(tNumberParsed));
      },
    );

    blocTest(
      'should emit Loading and Loaded when data is gotten succesfully',
      setUp: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Loading(),
        Loaded(tNumberTrivia),
      ],
    );

    blocTest(
      'should emit Loading and Errored when getting data fails from the server',
      setUp: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Loading(),
        Errored(serverFailureMessage),
      ],
    );

    blocTest(
      'should emit Loading and Errored when getting data fails from the cache',
      setUp: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Loading(),
        Errored(cacheFailureMessage),
      ],
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia("Test random trivia", 123);

    blocTest(
      'should get data from the Random use case',
      setUp: () {
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      verify: (bloc) {
        verify(mockGetRandomNumberTrivia());
      },
    );

    blocTest(
      'should emit Loading and Loaded when data is gotten succesfully',
      setUp: () {
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        Loaded(tNumberTrivia),
      ],
    );

    blocTest(
      'should emit Loading and Errored when getting data fails from the server',
      setUp: () {
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        Errored(serverFailureMessage),
      ],
    );

    blocTest(
      'should emit Loading and Errored when getting data fails from the cache',
      setUp: () {
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        Errored(cacheFailureMessage),
      ],
    );
  });
}

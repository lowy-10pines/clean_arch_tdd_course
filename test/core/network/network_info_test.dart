import 'package:clean_arch_tdd_course/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnection>()])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnection mockInternetConnection;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(mockInternetConnection);
  });

  group('#isConnected', () {
    test('should forward the call to InternetConnection.hasInternetAccess',
        () async {
      // arrange
      final tHasInternetFuture = Future.value(true);
      when(mockInternetConnection.hasInternetAccess)
          .thenAnswer((_) => tHasInternetFuture);
      // act
      final result = networkInfo.isConnected;
      // assert
      verify(mockInternetConnection.hasInternetAccess);
      expect(result, tHasInternetFuture);
    });
  });
}

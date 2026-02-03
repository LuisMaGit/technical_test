import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_doodle/core/models/theme_model.dart';
import 'package:test_doodle/core/models/transactions/transaction_model.dart';
import 'package:test_doodle/core/services/theme_service.dart';
import 'package:test_doodle/core/services/transaction_service/i_transaction_db_service.dart';
import 'package:test_doodle/locator.dart';
import 'package:test_doodle/router/navigator_service.dart';

import 'services_mocks.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ITransactionDBService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ThemeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NavigatorService>(onMissingStub: OnMissingStub.returnDefault),
])
ITransactionDBService getAndRegisterITransactionDBService({
  List<TransactionModel>? getAllTransactionsStub,
  List<TransactionModel>? getAllTransactionsStubByCategoryStub,
  double? getTotalAmountStub,
}) {
  removeRegistrationIfExists<ITransactionDBService>();
  final mock = MockITransactionDBService();

  if (getAllTransactionsStub != null) {
    when(
      mock.getAllTransactions(),
    ).thenAnswer((_) async => getAllTransactionsStub);
  }

  if (getAllTransactionsStubByCategoryStub != null) {
    when(
      mock.getTransactionsByCategory(isExpense: anyNamed('isExpense')),
    ).thenAnswer((_) async => getAllTransactionsStubByCategoryStub);
  }

  if (getTotalAmountStub != null) {
    when(mock.getTotalAmount()).thenAnswer((_) async => getTotalAmountStub);
  }

  locator.registerSingleton<ITransactionDBService>(mock);
  return mock;
}

ThemeService getAndRegisterThemeService({Stream<ThemeModel>? themeStreamStub}) {
  removeRegistrationIfExists<ThemeService>();
  final mock = MockThemeService();

  if (themeStreamStub != null) {
    when(mock.themeStream).thenAnswer((_) => themeStreamStub);
  }

  locator.registerSingleton<ThemeService>(mock);
  return mock;
}

NavigatorService getAndRegisterNavigatorService() {
  removeRegistrationIfExists<NavigatorService>();
  final mock = MockNavigatorService();
  locator.registerSingleton<NavigatorService>(mock);
  return mock;
}

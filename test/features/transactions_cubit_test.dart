import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_doodle/core/models/basic_ui_state.dart';
import 'package:test_doodle/core/models/theme_model.dart';
import 'package:test_doodle/core/models/transactions/transaction_model.dart';
import 'package:test_doodle/core/services/theme_service.dart';
import 'package:test_doodle/core/services/transaction_service/i_transaction_db_service.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_props.dart';
import 'package:test_doodle/features/transactions/transactions_cubit.dart';
import 'package:test_doodle/locator.dart';
import 'package:test_doodle/router/navigator_service.dart';
import 'package:test_doodle/router/routes.dart';

import '../services_mocks/services_mocks.dart';
import '../services_mocks/services_mocks.mocks.dart';

void main() {
  setUpAll(() {
    getAndRegisterITransactionDBService();
    getAndRegisterThemeService();
    getAndRegisterNavigatorService();
  });

  tearDownAll(() {
    removeRegistrationIfExists<ITransactionDBService>();
    removeRegistrationIfExists<ThemeService>();
    removeRegistrationIfExists<NavigatorService>();
  });

  final transactionsSample = [
    TransactionModel(
      id: 1,
      expenseCategory: .entertainment,
      amount: 50.0,
      isExpense: true,
      date: DateTime(1),
    ),
    TransactionModel(
      id: 2,
      incomeCategory: .salary,
      amount: 1500.0,
      date: DateTime(2),
    ),
  ];

  group('TransactionsCubit - ', () {
    group('initTransactions - ', () {
      test('should listen to theme changes on init', () async {
        // arrange
        final themeService = getAndRegisterThemeService(
          themeStreamStub: Stream<ThemeModel>.fromIterable([ThemeModel.light]),
        );

        // act
        final cubit = TransactionsCubit();
        await cubit.initTransactions();

        // assert
        verify(themeService.themeStream).called(1);
        expect(cubit.state.themeMode, ThemeModel.light);
      });

      test(
        'should fetch all transactions on init and the total amount',
        () async {
          // arrange
          final transactionsDBService = getAndRegisterITransactionDBService(
            getAllTransactionsStub: transactionsSample,
            getTotalAmountStub: 100,
          );

          // act
          final cubit = TransactionsCubit();
          await cubit.initTransactions();

          // assert
          verify(transactionsDBService.getAllTransactions()).called(1);
          verify(transactionsDBService.getTotalAmount()).called(1);
          expect(cubit.state.transactions, transactionsSample);
          expect(cubit.state.amount, 100);
          expect(cubit.state.categoryType, TransactionCategoryType.all);
          expect(cubit.state.screenState, BasicUIState.success);
        },
      );
    });

    group('onTapTransactionCategory - ', () {
      test(
        'should not fetch transactions if the selected category is the same as the current one',
        () async {
          // arrange
          final transactionsDBService =
              getAndRegisterITransactionDBService()
                  as MockITransactionDBService;

          final cubit = TransactionsCubit();
          await cubit.initTransactions();

          // act
          await cubit.onTapTransactionCategory(TransactionCategoryType.all);

          // assert
          verify(
            transactionsDBService.getAllTransactions(),
          ).called(1); // initial call
        },
      );

      test(
        'should fetch transactions by category when a different category is selected',
        () async {
          // arrange
          final transactionsDBService = getAndRegisterITransactionDBService(
            getTotalAmountStub: 200,
            getAllTransactionsStubByCategoryStub: transactionsSample,
          );

          final cubit = TransactionsCubit();
          await cubit.initTransactions();

          // act
          await cubit.onTapTransactionCategory(TransactionCategoryType.expense);

          // assert
          verify(
            transactionsDBService.getTransactionsByCategory(isExpense: true),
          ).called(1);
          verify(
            transactionsDBService.getTotalAmount(),
          ).called(2); // initial + on category change
          expect(cubit.state.transactions, transactionsSample);
          expect(cubit.state.amount, 200);
          expect(cubit.state.categoryType, TransactionCategoryType.expense);
          expect(cubit.state.screenState, BasicUIState.success);
        },
      );
    });

    group('toggleThemeMode - ', () {
      test('should toggle the theme mode', () async {
        // arrange
        final themeService = getAndRegisterThemeService(
          themeStreamStub: Stream<ThemeModel>.fromIterable([ThemeModel.light]),
        );

        final cubit = TransactionsCubit();
        await cubit.initTransactions();

        // act
        await cubit.toggleThemeMode();

        // assert
        verify(themeService.changeTheme(.dark));
      });
    });

    group('onTapAddExpense - ', () {
      test(
        'should navigate to the transaction editor screen in expense mode and refresh the transactions list',
        () async {
          // arrange
          final navigatorService = getAndRegisterNavigatorService();
          final transactionsDBService = getAndRegisterITransactionDBService(
            getAllTransactionsStub: transactionsSample,
          );

          final cubit = TransactionsCubit();
          await cubit.initTransactions();

          // act
          await cubit.onTapAddExpense();

          // assert
          verify(
            navigatorService.goTo(
              Routes.transactionEditor,
              arguments: TransactionEditorProps(type: .create, isExpense: true),
            ),
          );
          verify(
            transactionsDBService.getAllTransactions(),
          ).called(2); // initial + after navigation
        },
      );
    });

    group('onTapAddIncome - ', () {
      test(
        'should navigate to the transaction editor screen in income mode and refresh the transactions list',
        () async {
          // arrange
          final navigatorService = getAndRegisterNavigatorService();
          final transactionsDBService = getAndRegisterITransactionDBService(
            getAllTransactionsStub: transactionsSample,
          );

          final cubit = TransactionsCubit();
          await cubit.initTransactions();

          // act
          await cubit.onTapAddIncome();

          // assert
          verify(
            navigatorService.goTo(
              Routes.transactionEditor,
              arguments: TransactionEditorProps(type: .create, isExpense: false),
            ),
          );
          verify(
            transactionsDBService.getAllTransactions(),
          ).called(2); // initial + after navigation
        },
      );
    });

    group('onTapTransaction - ', (){

      test(
        'should navigate to the transaction editor screen in edit mode and refresh the transactions list',
        () async {
          // arrange
          final navigatorService = getAndRegisterNavigatorService();
          final transactionsDBService = getAndRegisterITransactionDBService(
            getAllTransactionsStub: transactionsSample,
          );

          final cubit = TransactionsCubit();
          await cubit.initTransactions();

          // act
          await cubit.onTapTransaction(1);

          // assert
          verify(
            navigatorService.goTo(
              Routes.transactionEditor,
              arguments: TransactionEditorProps(
                type: .edit,
                isExpense: true,
                transaction: transactionsSample[0],
              ),
            ),
          );
          verify(
            transactionsDBService.getAllTransactions(),
          ).called(2); // initial + after navigation
        },
      );

    });
  });
}

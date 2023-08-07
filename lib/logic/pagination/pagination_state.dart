import 'package:walper/libs.dart';

@immutable
abstract class PaginationState {}

class PaginationInitialState extends PaginationState {
  @override
  String toString() {
    return 'PaginationInitialState';
  }
}

class UserListRefreshState extends PaginationState {
  @override
  String toString() {
    return 'UserListRefreshState';
  }
}

class SnackbarEvent extends PaginationState {
  final String message;
  final bool isError;

  SnackbarEvent({required this.message, required this.isError});

  @override
  String toString() {
    return 'SnackbarEvent';
  }
}

import 'package:flutter/material.dart';

@immutable
abstract class PaginationEvent {}

class PaginationInitialEvent extends PaginationEvent {}

class GetPaginationDataEvent extends PaginationEvent {
  @override
  String toString() {
    return 'GetPaginationDataEvent';
  }
}

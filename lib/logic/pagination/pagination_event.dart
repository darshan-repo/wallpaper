import 'package:walper/libs.dart';

@immutable
abstract class PaginationEvent {}

class PaginationInitialEvent extends PaginationEvent {
  final String events;

  PaginationInitialEvent({required this.events});
}

class GetRecentPaginationDataEvent extends PaginationEvent {}

class GetTrendingPaginationDataEvent extends PaginationEvent {}

class GetExclusivePaginationDataEvent extends PaginationEvent {}

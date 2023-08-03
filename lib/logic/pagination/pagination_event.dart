import 'package:flutter/material.dart';

@immutable
abstract class PaginationEvent {}

class PaginationInitialEvent extends PaginationEvent {}

class GetRecentPaginationDataEvent extends PaginationEvent {}

class GetTrendingPaginationDataEvent extends PaginationEvent {}

class GetExclusivePaginationDataEvent extends PaginationEvent {}

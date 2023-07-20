part of 'collection_bloc_bloc.dart';

@immutable
abstract class CollectionBlocState {}

class CollectionBlocInitial extends CollectionBlocState {}

class CollectionLoading extends CollectionBlocState {}

class CollectionLoaded extends CollectionBlocState {}

class CollectionError extends CollectionBlocState {}

part of 'collection_bloc_bloc.dart';

@immutable
abstract class CollectionBlocEvent {}

class GetWallpaper extends CollectionBlocEvent {}

class GetCollection extends CollectionBlocEvent {
  final String id;
  final String category;
  GetCollection({required this.id,required this.category});
}

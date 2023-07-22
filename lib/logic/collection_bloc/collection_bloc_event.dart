part of 'collection_bloc_bloc.dart';

@immutable
abstract class CollectionBlocEvent {}

class GetWallpaper extends CollectionBlocEvent {}

class GetCollection extends CollectionBlocEvent {
  final String id;
  final String category;
  GetCollection({required this.id, required this.category});
}

class SendLikedWallpaper extends CollectionBlocEvent {
  final String id;
  final String userId;
  final String name;
  final String category;
  final String wallpaper;

  SendLikedWallpaper({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.wallpaper,
  });
}

class GetLikedWallpaper extends CollectionBlocEvent {
  final String id;
  GetLikedWallpaper({required this.id});
}

class SendDownloadWallpaper extends CollectionBlocEvent {
  final String id;
  final String userId;
  final String name;
  final String category;
  final String wallpaper;

  SendDownloadWallpaper({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.wallpaper,
  });
}

class GetDownloadWallpaper extends CollectionBlocEvent {
  final String id;
  GetDownloadWallpaper({required this.id});
}

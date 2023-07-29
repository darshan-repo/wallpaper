part of 'collection_bloc_bloc.dart';

@immutable
abstract class CollectionBlocEvent {}

class GetAllWallpaper extends CollectionBlocEvent {}

class GetWallpaper extends CollectionBlocEvent {}

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

class GetLikedWallpaper extends CollectionBlocEvent {}

class SendDissLikeWallpaper extends CollectionBlocEvent {
  final String id;
  final String userId;

  SendDissLikeWallpaper({required this.id, required this.userId});
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

class DeleteDownloadWallpaper extends CollectionBlocEvent {
  final String id, userId;

  DeleteDownloadWallpaper({
    required this.id,
    required this.userId,
  });
}

class ReportAndIssue extends CollectionBlocEvent {
  final String email, subject, message;

  ReportAndIssue({
    required this.email,
    required this.subject,
    required this.message,
  });
}

class GetTrendingWallpaper extends CollectionBlocEvent {}

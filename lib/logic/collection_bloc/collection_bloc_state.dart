part of 'collection_bloc_bloc.dart';

@immutable
abstract class CollectionBlocState {}

class CollectionBlocInitial extends CollectionBlocState {}

class CollectionLoading extends CollectionBlocState {}

class CollectionLoaded extends CollectionBlocState {}

class CollectionError extends CollectionBlocState {}

class CollectionInitialState extends CollectionBlocState {
  CollectionInitialState();
}

class CollectionLoadingState extends CollectionBlocState {
  final String message;

  CollectionLoadingState({required this.message});
}

class CollectionSuccessState extends CollectionBlocState {
  final List<Wallpaper> allWallpaper;

  CollectionSuccessState(this.allWallpaper);
}

class CollectionErrorState extends CollectionBlocState {
  final String error;

  CollectionErrorState({required this.error});
}

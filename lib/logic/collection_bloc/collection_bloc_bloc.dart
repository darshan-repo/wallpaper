import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

part 'collection_bloc_event.dart';

part 'collection_bloc_state.dart';

class CollectionBlocBloc
    extends Bloc<CollectionBlocEvent, CollectionBlocState> {
  CollectionBlocBloc() : super(CollectionBlocInitial()) {
    on<GetWallpaper>(_getWallPaper);
    on<GetCollection>(_getCollection);
  }

  GetWallpaperModel? getWallpaperModel;

  _getWallPaper(GetWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.getRequest("allcategories");
      log("REAPONAE ::$data");
      if (data["message"] == "all categories") {
        getWallpaperModel = GetWallpaperModel.fromJson(data);
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  GetCollectionModel? getCollectionModel;

  _getCollection(GetCollection event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.getRequest("getWallpaperByCategory/${event.id}");
      log("REAPONAE ::$data");
      if (data["data"] != null) {
        getCollectionModel = GetCollectionModel.fromJson(data);
        Get.to(CollectionViewScreen(id: event.id, category: event.category));
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }
}

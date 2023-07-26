import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:walper/models/download_model.dart';
import 'package:walper/models/get_all_wallpaper.dart';

part 'collection_bloc_event.dart';

part 'collection_bloc_state.dart';

class CollectionBlocBloc
    extends Bloc<CollectionBlocEvent, CollectionBlocState> {
  CollectionBlocBloc() : super(CollectionBlocInitial()) {
    on<GetAllWallpaper>(_getAllWallPaper);
    on<GetWallpaper>(_getWallPaper);
    on<GetCollection>(_getCollection);
    on<SendLikedWallpaper>(_sendLikedWallpaper);
    on<GetLikedWallpaper>(_getLikedWallpaper);
    on<SendDownloadWallpaper>(_sendDownloadWallpaper);
    on<GetDownloadWallpaper>(_getDownloadWallpaper);
    on<DeleteDownloadWallpaper>(_deleteDownloadWallpaper);
  }

  GetAllWallpaperModel? getAllWallpaperModel;
  GetCollectionModel? getCollectionModel;
  GetLikeModel? getLikedModel;
  GetWallpaperModel? getWallpaperModel;
  SendLikeModel? sendLikeModelData;

  _getAllWallPaper(
      GetAllWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.getRequest("allWallpapers");
      log("RESPONSE :: $data");
      if (data["message"] != null) {
        getAllWallpaperModel = GetAllWallpaperModel.fromJson(data);
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  _getWallPaper(GetWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.getRequest("allcategories");
      log("RESPONSE :: $data");
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

  _getCollection(GetCollection event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.getRequest("getWallpaperByCategory/${event.id}");
      log("RESPONSE :: $data");
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

  _sendLikedWallpaper(
      SendLikedWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.postRequest("like/${event.id}", data: {
        "userId": event.userId,
        "name": event.name,
        "category": event.category,
        "wallpaper": event.wallpaper,
      });
      log("RESPONSE :: $data");
      if (data["data"] != null) {
        sendLikeModelData = SendLikeModel.fromJson(data);
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  _getLikedWallpaper(
      GetLikedWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.getRequest("getLikesByUser/${event.id}");
      log("RESPONSE :: $data");
      if (data["message"] == "likes fetched") {
        getLikedModel = GetLikeModel.fromJson(data);
        Get.to(const FavoriteScreen());
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  SendDownloadModel? sendDownloadModel;
  _sendDownloadWallpaper(
      SendDownloadWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.postRequest("download/${event.id}", data: {
        "userId": event.userId,
        "name": event.name,
        "category": event.category,
        "wallpaper": event.wallpaper,
      });
      log("RESPONSE :: $data");
      if (data["data"] != null) {
        sendDownloadModel = SendDownloadModel.fromJson(data);
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  GetDownloadModel? getDownloadModel;
  _getDownloadWallpaper(
      GetDownloadWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.getRequest("getDownloadsByUser/${event.id}");
      log("RESPONSE :: $data");
      if (data["message"] == "downloads fetched") {
        getDownloadModel = GetDownloadModel.fromJson(data);
        Get.to(const DownloadScreen());
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  //  GetDownloadModel? getDownloadModel;
  _deleteDownloadWallpaper(
      DeleteDownloadWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest(
          "removeDownload/${event.id}",
          data: {'userId': event.userId});
      log("RESPONSE :: $data");
      if (data["message"] == "downloaded wallpaper removed") {
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

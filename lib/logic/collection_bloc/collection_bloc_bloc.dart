// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:walper/models/get_home_featured_wallpaper.dart';


part 'collection_bloc_event.dart';

part 'collection_bloc_state.dart';

class CollectionBlocBloc
    extends Bloc<CollectionBlocEvent, CollectionBlocState> {
  CollectionBlocBloc() : super(CollectionBlocInitial()) {
    on<GetAllWallpaper>(_getAllWallPaper);
    on<GetWallpaper>(_getWallPaper);
    on<GetHomeFeatured>(_getHomeFeatured);
    on<SendLikedWallpaper>(_sendLikedWallpaper);
    on<GetLikedWallpaper>(_getLikedWallpaper);
    on<SendDownloadWallpaper>(_sendDownloadWallpaper);
    on<GetDownloadWallpaper>(_getDownloadWallpaper);
    on<DeleteDownloadWallpaper>(_deleteDownloadWallpaper);
    on<SendDissLikeWallpaper>(_sendDissLikedWallpaper);
    on<ReportAndIssue>(_reportAndIssue);
    on<GetTrendingWallpaper>(_getTrendingWallpaper);
    on<EnabledNotification>(_postEnabledNotification);
  }

  GetAllWallpaperModel? getAllWallpaperModel;
  GetCollectionModel? getCollectionModel;
  GetLikeModel? getLikedModel;
  GetWallpaperModel? getWallpaperModel;
  SendLikeModel? sendLikeModelData;
  GetFeaturedWallpaperModel? getFeaturedWallpaperModel;

  int page = 1;
  bool isFetching = false;

  _getAllWallPaper(
      GetAllWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      log("pageeeeeeeeeeee $page");
      Map<String, dynamic> data =
          await BaseApi.getRequest("allWallpapers?page=$page");
      log("RESPONSE :: $data");
      if (data["message"] != null) {
        getAllWallpaperModel = GetAllWallpaperModel.fromJson(data);
        Get.to(const BottomNavigationBarScreen());
        page++;
        emit(CollectionLoaded());
        emit(
            CollectionSuccessState(getAllWallpaperModel!.wallpapers!.toList()));
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

  _getHomeFeatured(
      GetHomeFeatured event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.getRequest("allcategories");
      log("RESPONSE :: $data");
      if (data["message"] == "all categories") {
        getFeaturedWallpaperModel = GetFeaturedWallpaperModel.fromJson(data);
        BlocProvider.of<CollectionBlocBloc>(event.context)
            .add(GetAllWallpaper());
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
    // emit(CollectionLoading());
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
        add(GetLikedWallpaper());
        sendLikeModelData = SendLikeModel.fromJson(data);
        emit(CollectionLoaded());
      } else {
        add(GetLikedWallpaper());

        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  _getLikedWallpaper(
      GetLikedWallpaper event, Emitter<CollectionBlocState> emit) async {
    // emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.getRequest(
          "getLikesByUser/${UserPreferences.getUserId()}");
      log("RESPONSE :: $data");
      if (data["message"] == "likes fetched") {
        getLikedModel = GetLikeModel.fromJson(data);
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  _sendDissLikedWallpaper(
      SendDissLikeWallpaper event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest(
          "removeLike/${event.id}",
          data: {'userId': event.userId});
      log("RESPONSE :: $data");
      if (data["data"] != null) {
        add(GetLikedWallpaper());
        emit(CollectionLoaded());
      } else {
        add(GetLikedWallpaper());
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
        // Get.to(const DownloadScreen());
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

  _reportAndIssue(
      ReportAndIssue event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("report", data: {
        "email": event.email,
        "subject": event.subject,
        "message": event.message
      });
      log("RESPONSE :: $data");
      if (data["data"] != null) {
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  GetTrendingWallpaperModel? getTrendingWallpaperModel;

  _getTrendingWallpaper(
      GetTrendingWallpaper event, Emitter<CollectionBlocState> emit) async {
    try {
      Map<String, dynamic> data = await BaseApi.getRequest("getAllLikesData");
      log("RESPONSE :: $data");
      if (data["message"] == "all categories") {
        getTrendingWallpaperModel = GetTrendingWallpaperModel.fromJson(data);
        emit(CollectionLoaded());
      } else {
        emit(CollectionLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(CollectionError());
    }
  }

  _postEnabledNotification(
      EnabledNotification event, Emitter<CollectionBlocState> emit) async {
    try {
      Map<String, dynamic> data =
          await BaseApi.postRequest("enableNotification", data: {
        "email": event.email,
        "deviceId": event.deviceId,
      });
      log("RESPONSE :: $data");
      if (data["data"] != null) {
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

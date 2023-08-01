import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:walper/base_api/base_api.dart';
import 'package:walper/logic/pagination/pagination_event.dart';
import 'package:walper/logic/pagination/pagination_state.dart';
import 'package:walper/models/get_all_wallpaper.dart';
import 'package:walper/presentation/modules/bottom_navigaton_bar/bottom_navigation_bar.dart';

ScrollController? scrollController;

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc() : super(PaginationInitialState()) {
    on<GetPaginationDataEvent>(_getPaginationDataEvent);
    on<PaginationInitialEvent>(_viewFilteredListInitialEvent);
  }

  List<Wallpaper>? allWallpaper;
  bool isScreenLoading = false;
  bool isPageLoading = true;
  bool isNewPageLoading = false;
  int page = 1;
  int limit = 4;
  GetAllWallpaperModel? getAllWallpaperModel;

  Future<void> _getPaginationDataEvent(
      GetPaginationDataEvent event, Emitter<PaginationState> emit) async {
    if (isPageLoading && !isNewPageLoading) {
      try {
        isNewPageLoading = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController?.jumpTo(
            scrollController!.position.maxScrollExtent,
          );
        });
        emit(UserListRefreshState());
        Map<String, dynamic> data =
            await BaseApi.getRequest("allWallpapers?page=$page&limit=$limit");
        if (data["message"] != null) {
          getAllWallpaperModel = GetAllWallpaperModel.fromJson(data);
        }
        if (getAllWallpaperModel?.wallpapers != null) {
          if (getAllWallpaperModel?.wallpapers?.isEmpty ?? false) {
            isPageLoading = false;
          } else {
            allWallpaper ??= [];
            allWallpaper!.addAll(getAllWallpaperModel!.wallpapers!.toList());
            page++;
            emit(UserListRefreshState());
          }
        } else {
          isPageLoading = false;
        }
      } catch (error, stack) {
        debugPrint(error.toString());
        debugPrint(stack.toString());
      } finally {
        isNewPageLoading = false;
        emit(UserListRefreshState());
      }
    }
  }

  Future<void> _viewFilteredListInitialEvent(
      PaginationInitialEvent event, Emitter<PaginationState> emit) async {
    isScreenLoading = true;
    emit(UserListRefreshState());
    try {
      allWallpaper = [];

      add(GetPaginationDataEvent());
    } catch (error, stack) {
      debugPrint(error.toString());
      debugPrint(stack.toString());
    } finally {
      isScreenLoading = false;
      emit(UserListRefreshState());
    }
  }
}

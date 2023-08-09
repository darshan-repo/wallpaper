import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

ScrollController? scrollController;

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc() : super(PaginationInitialState()) {
    on<GetExclusivePaginationDataEvent>(_getExclusivePaginationDataEvent);
    on<GetRecentPaginationDataEvent>(_getRecentPaginationDataEvent);
    on<GetTrendingPaginationDataEvent>(_getTrendingPaginationDataEvent);
    on<PaginationInitialEvent>(_viewInitialEvent);
  }

  List<Wallpaper>? allWallpaper;

  bool isScreenLoading = false;
  bool isPageLoading = true;
  bool isNewPageLoading = false;
  int page = 1;
  int limit = 10;
  AllWallpaperModel? allWallpaperModel;

  Future<void> _getExclusivePaginationDataEvent(
      GetExclusivePaginationDataEvent event,
      Emitter<PaginationState> emit) async {
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
          allWallpaperModel = AllWallpaperModel.fromJson(data);
        }
        if (allWallpaperModel?.wallpapers != null) {
          if (allWallpaperModel?.wallpapers?.isEmpty ?? false) {
            isPageLoading = false;
          } else {
            allWallpaper ??= [];
            allWallpaper!.addAll(allWallpaperModel!.wallpapers!.toList());
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

  Future<void> _getRecentPaginationDataEvent(
      GetRecentPaginationDataEvent event, Emitter<PaginationState> emit) async {
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
            await BaseApi.getRequest("recent?page=$page&limit=$limit");
        if (data["message"] != null) {
          allWallpaperModel = AllWallpaperModel.fromJson(data);
        }
        if (allWallpaperModel?.wallpapers != null) {
          if (allWallpaperModel?.wallpapers?.isEmpty ?? false) {
            isPageLoading = false;
          } else {
            allWallpaper ??= [];
            allWallpaper!.addAll(allWallpaperModel!.wallpapers!.toList());
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

  Future<void> _getTrendingPaginationDataEvent(
      GetTrendingPaginationDataEvent event,
      Emitter<PaginationState> emit) async {
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
            await BaseApi.getRequest("getAllLikesData?page=$page&limit=$limit");
        if (data["message"] != null) {
          allWallpaperModel = AllWallpaperModel.fromJson(data);
        }
        if (allWallpaperModel?.wallpapers != null) {
          if (allWallpaperModel?.wallpapers?.isEmpty ?? false) {
            isPageLoading = false;
          } else {
            allWallpaper ??= [];
            allWallpaper!.addAll(allWallpaperModel!.wallpapers!.toList());
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

  Future<void> _viewInitialEvent(
      PaginationInitialEvent event, Emitter<PaginationState> emit) async {
    isScreenLoading = true;
    emit(UserListRefreshState());
    try {
      allWallpaper = [];
      if (event.events == 'Exclusive') {
        isNewPageLoading = false;
        isPageLoading = true;
        page = 1;
        add(GetExclusivePaginationDataEvent());
      } else if (event.events == "Trending") {
        isNewPageLoading = false;
        isPageLoading = true;
        page = 1;
        add(GetTrendingPaginationDataEvent());
      } else {
        isNewPageLoading = false;
        isPageLoading = true;
        page = 1;
        add(GetRecentPaginationDataEvent());
      }
    } catch (error, stack) {
      debugPrint(error.toString());
      debugPrint(stack.toString());
    } finally {
      isScreenLoading = false;
      emit(UserListRefreshState());
    }
  }
}

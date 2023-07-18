import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/base_api/base_api.dart';

part 'collection_bloc_event.dart';
part 'collection_bloc_state.dart';

class CollectionBlocBloc
    extends Bloc<CollectionBlocEvent, CollectionBlocState> {
  CollectionBlocBloc() : super(CollectionBlocInitial()) {
    on<AbstractCollection>(abstractCollection);
  }
  abstractCollection(
      AbstractCollection event, Emitter<CollectionBlocState> emit) async {
    emit(CollectionLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.getRequest("getWallpaperByCategory/abstract");

      if (data["status"]) {
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

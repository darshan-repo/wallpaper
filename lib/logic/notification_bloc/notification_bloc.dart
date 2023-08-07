import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<GetNotification>(_getNotification);
  }

  GetNotificationModel? getNotificationModel;

  _getNotification(
      GetNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      Map<String, dynamic> data = await BaseApi.getRequest("notifications");
      if (data["message"] != null) {
        getNotificationModel = GetNotificationModel.fromJson(data);
        emit(NotificationLoaded());
      } else {
        emit(NotificationLoaded());
      }
    } catch (e) {
      log(e.toString());
      emit(NotificationError());
    }
  }
}

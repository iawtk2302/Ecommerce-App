import 'dart:async';

import 'package:ecommerce_app/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatRoom>(_onLoadChatRoom);
  }

  FutureOr<void> _onLoadChatRoom(
      LoadChatRoom event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    await ChatRepository()
        .checkAndCreateChatRoom(event.id, event.name, event.imgUrl);
    final List<String> ids = [event.id, 'admin'];
    ids.sort();
    String idChatRoom = ids.join('_');
    emit(ChatLoaded(idChatRoom: idChatRoom));
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/revolt_client.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final RevoltClient client;
  late final StreamSubscription<Map<String, RelationUser>>
      friendsListStreamSubscription;
  HomeCubit({required this.client}) : super(HomeState()) {
    friendsListStreamSubscription =
        client.relationUsersStream.listen(_listenOnFriendListStream);
  }

  void _listenOnFriendListStream(Map<String, RelationUser> friendsList) {
    emit(state.copyWith(friendsList: friendsList));
  }

  submitFriendRequest(String username) async {
    client.sendFriendRequest(username: username);
  }

  acceptFriendRequest(String id) async {
    await client.acceptFriendRequest(id: id);
  }

  onSelectUser(String userId) async {
    final channel = await client.getDmChannelForUser(userId: userId);
    emit(state.copyWith(currentSelectedChannel: channel.id));
    setPage(page: 1,withAnimation: true);
  }

  setPage({required int page, required bool withAnimation}) {
    if (withAnimation) {
      emit(state.copyWith(page: PageState.withAnimation(page)));
    } else {
      emit(state.copyWith(page: PageState.withOutAnimation(page)));
    }
  }

  @override
  Future<void> close() {
    friendsListStreamSubscription.cancel();
    return super.close();
  }
}

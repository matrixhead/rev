import 'package:revolt_client/src/models/user/user.dart';
import 'package:revolt_client/src/state/authentication_repository.dart';
import 'package:revolt_client/src/state/channel_repository.dart';
import 'package:rxdart/rxdart.dart';

class RevState {
  RevState();
  final ChannelRepository channelRepo = ChannelRepository();
  final AuthenticationRepository authRepo = AuthenticationRepository();
  // TODO: move the following two fields to user repo 
  final BehaviorSubject<Map<String, RelationUser>> relationUsers =
      BehaviorSubject.seeded(
    {},
  );
  CurrentUser? currentUser;
}

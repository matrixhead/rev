import 'package:revolt_client/src/models/user/user.dart';
import 'package:revolt_client/src/state/channel_repository.dart';
import 'package:rxdart/rxdart.dart';

class RevState {
  RevState();
  final BehaviorSubject<Map<String, RelationUser>> relationUsers =
      BehaviorSubject.seeded(
    {},
  );
  CurrentUser? currentUser;
  final ChannelRepository channelRepo = ChannelRepository();
}

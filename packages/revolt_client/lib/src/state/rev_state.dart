import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/data/channel_repo.dart';
import 'package:rxdart/rxdart.dart';

class RevState {
  RevState();
  final ChannelRepositoryState channelRepoState = ChannelRepositoryState();
  final AuthenticationRepositoryState authRepoState =
      AuthenticationRepositoryState();
  final UserRepositoryState userRepoState = UserRepositoryState();
}

class UserRepositoryState {
  final BehaviorSubject<Map<String, RelationUser>> relationUsers =
      BehaviorSubject.seeded(<String, RelationUser>{});
  CurrentUser? currentUser;
  void addorUpdateRelationUsers(RelationUser user) {
    final users = Map<String, RelationUser>.from(relationUsers.value);
    users[user.id] = user;
    relationUsers.add(users);
  }
}

class ChannelRepositoryState {
  final Map<String, RevChannel> channels = {};
  final Map<String, String> dmchannelUserMappings = {};
}

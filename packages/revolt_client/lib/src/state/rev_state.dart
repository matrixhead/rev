import 'package:revolt_client/src/models/user/user.dart';
import 'package:revolt_client/src/state/authentication_repository.dart';
import 'package:revolt_client/src/state/channel_repository.dart';
import 'package:rxdart/rxdart.dart';

class RevState {
  RevState();
  final ChannelRepositoryState channelRepo = ChannelRepositoryState();
  final AuthenticationRepositoryState authRepoState =
      AuthenticationRepositoryState();
  // TODO: move the following two fields to user repo
  final BehaviorSubject<Map<String, RelationUser>> relationUsers =
      BehaviorSubject.seeded(<String, RelationUser>{});
  CurrentUser? currentUser;
  void addorUpdateRelationUsers(RelationUser user) {
    final users = Map<String, RelationUser>.from(relationUsers.value);
    users[user.id] = user;
    relationUsers.add(users);
  }
}

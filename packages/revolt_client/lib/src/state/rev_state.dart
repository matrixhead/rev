import 'package:revolt_client/src/models/user/user.dart';

class RevState {
  final Map<String, RelationUser> relationUsers = {};
  CurrentUser? currentUser;

  RevState();
}

import 'package:revolt_client/src/models/authmodels/authmodels.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationRepositoryState {
    BehaviorSubject<AuthStatus> authEvents =
      BehaviorSubject<AuthStatus>.seeded(AuthStatus.unknown, sync: true);
    SessionDetails? session;
}

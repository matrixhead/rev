import 'package:revolt_client/src/models/authmodels/authmodels.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationRepository {
    BehaviorSubject<AuthStatus> authEvents =
      BehaviorSubject<AuthStatus>.seeded(AuthStatus.unknown, sync: true);
    SessionDetails? session;
}

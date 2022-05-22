import 'package:revolt_client/src/revolt_client_base.dart';

void main() async {
  final revoltClient = RevoltClient();
  revoltClient.authEvents.listen((value) {
    print(value);
  });
  revoltClient.signUp(email: "example@gmail.com", password: "22jUhEtnRS3vJBf");
  await revoltClient.login(
      email: "example@gmail.com", password: "22jUhEtnRS3vJBf");
  print(revoltClient.authRepo.session);
}

import 'package:revolt_client/src/revolt_client_base.dart';

void main() async {
  final revoltClient = RevoltClient();
  revoltClient.authEvents.listen((value) {
    print(value);
  });

  final email = "example2@gmail.com";
  final password = "22jUhEtnRS3vJBf";

  // await revoltClient.signUp(email: email, password: password);

  // await revoltClient.verifyAccount(verificationCode: "ishjy9ZgvwwrzdTw4x1gxwikz73vbEky");

  await revoltClient.login(
      email: email, password:password);
  // await revoltClient.completeOnboarding(username: "hi");
  // print(revoltClient.revAuth.session);
  final res = await revoltClient.fetchSelf();
  print(res);
  while (true){}
}

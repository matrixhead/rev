import 'package:revolt_client/src/revolt_client_base.dart';

void main() async {
  final revoltClient = RevoltClient();
  revoltClient.authEvents.listen((value) {
    print(value);
  });
  // await revoltClient.signUp(email: "example1@gmail.com", password: "22jUhEtnRS3vJBf");
  // await revoltClient.verifyAccount(verificationCode: "VfN-y_8cNEicLz9hB2ZITj35i8fR3Tex");
  await revoltClient.login(
      email: "example1@gmail.com", password: "22jUhEtnRS3vJBf");
  while (true){}
  print(revoltClient.revAuth.session);
}

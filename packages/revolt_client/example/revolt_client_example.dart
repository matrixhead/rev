import 'dart:async';

import 'package:revolt_client/src/models/user/user.dart';
import 'package:revolt_client/src/revolt_client_base.dart';

Completer<CurrentUser> client1UserCompleter = Completer();
Completer<CurrentUser> client2UserCompleter = Completer();

void main() {
  // client1();
  client2();
}

Future<void> client1() async {
  final revoltClient = RevoltClient();
  revoltClient.authEvents.listen((value) {
    print(value);
  });

  final email = "example13@gmail.com";
  final password = "22jUhEtnRS3vJBf";

  // await revoltClient.signUp(email: email, password: password);
  // print("enter $email verification code: ");
  // String verificationCode = stdin.readLineSync()!;
  // await revoltClient.verifyAccount(verificationCode: verificationCode);

  await revoltClient.login(email: email, password: password);

  // await revoltClient.completeOnboarding(username: "hi");
  final currentUser = await revoltClient.fetchSelf();
  client1UserCompleter.complete(currentUser);

  // final client2User  = await client2UserCompleter.future;

  // final res = await revoltClient.sendFriendRequest(
  //     username: client2User.username,
  //     discriminator: client2User.discriminator);

  // final user = await revoltClient.fetchUser(id: "01JDPMTYA9X83XX55XBMNDX0M7");
  print("hi");
}

Future<void> client2() async {
  final revoltClient = RevoltClient();
  revoltClient.authEvents.listen((value) {
    print(value);
  });

  final email = "example14@gmail.com";
  final password = "22jUhEtnRS3vJBf";

  // await revoltClient.signUp(email: email, password: password);
  // print("enter $email verification code: ");
  // String verificationCode = stdin.readLineSync()!;
  // await revoltClient.verifyAccount(verificationCode: verificationCode);

  await revoltClient.login(email: email, password: password);

  // await revoltClient.completeOnboarding(username: "hi");
  final currentUser =  await revoltClient.fetchSelf();
  client2UserCompleter.complete(currentUser);

  // final user = await revoltClient.fetchUser(id: "01JDPMTYA9X83XX55XBMNDX0M7");

  // final res = await revoltClient.sendFriendRequest(
    // username: "hi", discriminator: "7837");

  print("hi");
  }

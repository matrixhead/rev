
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rebar/generated/locale_keys.g.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              print("${context.deviceLocale.toString()}");

              print(context.locale.toString());
            },
            child: Text(LocaleKeys.appName.tr()))
      ],
    );
  }
}

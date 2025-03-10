import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rev/generated/locale_keys.g.dart';
import 'package:rev/src/common/widgets/primary_button.dart';
import 'package:rev/src/common/widgets/form_text_field.dart';
import 'package:rev/src/pages/login_page/cubit/login_cubit.dart';
import 'package:rev/src/pages/signup_page/signup_page.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutofillGroup(
              child: Column(
                children: [
                  FormTextField(
                    key: UniqueKey(),
                    label: LocaleKeys.email.tr(),
                    onChanged: context.read<LoginCubit>().emailChanged,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormTextField(
                    key: UniqueKey(),
                    label: LocaleKeys.password.tr(),
                    onChanged: context.read<LoginCubit>().passwordChanged,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: [AutofillHints.password],
                    showObscureTextIcon: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            PrimaryButton(
              onPressed: context.read<LoginCubit>().onSubmit,
              label: LocaleKeys.login.tr(),
            ),
            RichText(text: TextSpan()),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("${LocaleKeys.newToRev.tr()} "),
                TextButton(
                    onPressed: () {
                      context.goNamed(SignupPage.route);
                    },
                    child: Text(LocaleKeys.createANewAccount.tr())),
              ],
            )
          ],
        ),
      ],
    );
  }
}

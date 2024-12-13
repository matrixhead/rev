import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/common/widgets/primary_button.dart';
import 'package:rebar/src/common/widgets/form_text_field.dart';
import 'package:rebar/src/pages/login_page/cubit/login_cubit.dart';
import 'package:rebar/src/pages/signup_page/signup_page.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FormTextField(
                label: "Email",
                onChanged: context.read<LoginCubit>().emailChanged,
              ),
              FormTextField(
                label: "Password",
                onChanged: context.read<LoginCubit>().passwordChanged,
              ),
              PrimaryButton(onPressed: context.read<LoginCubit>().onSubmit,label: "Login",),
            ],
          ),
        ),

              TextButton(onPressed: (){
                Navigator.of(context).pushNamed(SignupPage.route);
              }, child: Text("Signup"))
      ],
    );
  }
}





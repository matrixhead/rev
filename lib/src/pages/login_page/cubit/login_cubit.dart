import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/revolt_client.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final RevoltClient client;
  LoginCubit({required this.client}) : super(LoginState(email: "",password: ""));

  emailChanged(String email){
    emit(state.copyWith(email: email));
  }

  passwordChanged(String password){
    emit(state.copyWith(password: password));
  }

  onSubmit(){
   client.login(email: state.email,password: state.password); 
  }

}

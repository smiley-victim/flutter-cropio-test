
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/Features/Auth/Data/DataSource/authservice.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginAsGuest>(_loginAsGuest);
    on<EmailLogin>(_asEmailSignUp);
    // on<GoogleLogin>()
  }

  // void _getuser() async {
  //   AuthServiceImpl().getUser().listen((user) {
  //     if (user.current == true) {
  //       emit(AuthSuccess(user: user.deviceModel, userid: user.userId));
  //     }
  //   });
  // }

  void _loginAsGuest(LoginAsGuest event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // try {
    //   final reponse = await AuthServiceImpl().anonymousLogin();
    //   return emit(
    //       AuthSuccess(user: reponse.deviceModel, userid: reponse.userId));
    // } catch (e) {
    //   return emit(AuthFailure(e.toString()));
    // }
  }

  void _asEmailSignUp(EmailLogin event, Emitter<AuthState> emit) async {}

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    debugPrint(change.toString());
  }
}

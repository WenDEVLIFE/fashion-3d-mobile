import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../../authentication/models/auth_error_model.dart';
import '../../model/submit_review_response.dart';
import '../repository/review_submit_repository.dart';

part 'review_state.dart';

class SubmitReviewCubit extends Cubit<ReviewSubmitState> {
  final SubmitReviewRepository _repository;
  final LoginBloc _loginBloc;

  SubmitReviewCubit(
      {required LoginBloc loginBloc,
      required SubmitReviewRepository repository})
      : _loginBloc = loginBloc,
        _repository = repository,
        super(SubmitReviewStateLoading());

  Future<void> submitReview(Map<String, dynamic> body) async {
    emit(SubmitReviewStateLoading());

    final result = await _repository.submitReview(body,
        token: _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(SubmitReviewFormValidate(failure.errors));
        } else {
          emit(SubmitReviewStateError(failure.message));
        }
      },
      (data) {
        emit(SubmitReviewStateLoaded(data));
      },
    );
  }
}

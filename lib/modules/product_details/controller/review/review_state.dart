part of "review_cubit.dart";

abstract class ReviewSubmitState extends Equatable {
  const ReviewSubmitState();

  @override
  List<Object> get props => [];
}

class SubmitReviewStateLoading extends ReviewSubmitState {}

class ReviewStateLoading extends ReviewSubmitState {}

class SubmitReviewStateError extends ReviewSubmitState {
  final String errorMessage;

  const SubmitReviewStateError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class SubmitReviewFormValidate extends ReviewSubmitState {
  final Errors errors;

  const SubmitReviewFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

class SubmitReviewStateLoaded extends ReviewSubmitState {
  final SubmitReviewResponseModel submitReviewResponseModel;

  const SubmitReviewStateLoaded(this.submitReviewResponseModel);

  @override
  List<Object> get props => [submitReviewResponseModel];
}

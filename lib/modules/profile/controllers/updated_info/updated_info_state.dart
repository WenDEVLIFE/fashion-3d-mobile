part of 'updated_info_cubit.dart';

abstract class UserProfilenfoState extends Equatable {
  const UserProfilenfoState();

  @override
  List<Object> get props => [];
}

class UpdatedInfoInitial extends UserProfilenfoState {}

class UpdatedLoading extends UserProfilenfoState {}

class UpdatedLoaded extends UserProfilenfoState {
  final UserProfileInfo updatedInfo;

  const UpdatedLoaded({required this.updatedInfo});

  @override
  List<Object> get props => [updatedInfo];
}

class UpdatedError extends UserProfilenfoState {
  final String message;

  const UpdatedError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdatedState extends UserProfilenfoState {
  final String message;

  const ProfileUpdatedState({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdatedErrorState extends UserProfilenfoState {
  final String message;

  const ProfileUpdatedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

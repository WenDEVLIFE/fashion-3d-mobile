part of 'flash_cubit.dart';

abstract class FlashState extends Equatable {
  const FlashState();

  @override
  List<Object> get props => [];
}

class FlashInitial extends FlashState {}

class FlashSaleLoading extends FlashState {}

class FlashSaleError extends FlashState {
  final String errorMessage;
  final int statusCode;
  const FlashSaleError({
    required this.errorMessage,
    required this.statusCode,
  });

  @override
  List<Object> get props => [errorMessage, statusCode];
}

class FlashSaleLoaded extends FlashState {
  final FlashModel flashModel;
  const FlashSaleLoaded({required this.flashModel});

  @override
  List<Object> get props => [flashModel];
}

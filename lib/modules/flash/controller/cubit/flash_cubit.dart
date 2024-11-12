import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/flash_model.dart';
import '../flash_repository.dart';

part 'flash_state.dart';

class FlashCubit extends Cubit<FlashState> {
  FlashCubit(FlashRepository flashRepository)
      : _repository = flashRepository,
        super(FlashSaleLoading()) {
    getFalshSale();
  }

  final FlashRepository _repository;
  FlashModel? flashModel;

  Future<void> getFalshSale() async {
    emit(FlashSaleLoading());

    final result = await _repository.getFlashSale();
    result.fold(
      (failuer) {
        emit(FlashSaleError(
            errorMessage: failuer.message, statusCode: failuer.statusCode));
      },
      (data) {
        flashModel = data;
        emit(FlashSaleLoaded(flashModel: data));
      },
    );
  }
}

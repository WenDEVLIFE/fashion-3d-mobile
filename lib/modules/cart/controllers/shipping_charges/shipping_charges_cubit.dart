import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shipping_charges_state.dart';

class ShippingChargesCubit extends Cubit<ShippingChargesState> {
  ShippingChargesCubit() : super(ShippingChargesInitial());
  double initialPrice = 0.0;

  void getShippingCharge(double price) {
    emit(ShippingChargesInitial());
    initialPrice = price;
    emit(ShippingChargesAddedState());
  }
}

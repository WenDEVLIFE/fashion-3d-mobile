import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authentication/controller/login/login_bloc.dart';
import '../../../model/city_model.dart';
import '../../../model/country_model.dart';
import '../../../model/country_state_model.dart';
import '../../../model/edit_address_model.dart';
import '../../repository/profile_repository.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  final ProfileRepository _profileRepository;
  final LoginBloc _loginBloc;
  EditAddressCubit({
    required ProfileRepository profileRepository,
    required LoginBloc loginBloc,
  })  : _profileRepository = profileRepository,
        _loginBloc = loginBloc,
        super(EditAddressInitial());

  List<CountryModel> countryList = [];
  List<CountryStateModel> stateList = [];
  List<CityModel> cities = [];

  late EditAddressModel editAddressModel;

  Future<void> fetchEditAddress(String id) async {
    emit(EditAddressLoading());

    final result = await _profileRepository.editAddress(
        id, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(EditAddressStateUpdateError(failure.message, failure.statusCode));
      },
      (successData) {
        editAddressModel = successData;

        countryList = successData.countries.toSet().toList();
        stateList = successData.states.toSet().toList();
        cities = successData.cities.toSet().toList();
        emit(EditAddressStateLoaded(successData));
      },
    );
  }

  CountryStateModel? defaultState(String id) {
    print("edit.stateModel $stateList");
    for (var item in stateList) {
      if (item.id.toString() == id) {
        return item;
      }
    }
    return null;
  }

  CityModel? defaultCity(String id) {
    print("edit.cityModel $cities");
    for (var item in cities) {
      if (item.id.toString() == id) {
        return item;
      }
    }
    return null;
  }
}

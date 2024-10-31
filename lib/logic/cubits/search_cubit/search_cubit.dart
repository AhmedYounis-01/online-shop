import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shop_app/data/end_point.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/presentation/widgets/constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: search1,
      data: {"text": text},
      token: token,
    ).then(
      (value) {
        searchModel = SearchModel.fromJson(value!.data);
        emit(SearchSuccessState());
      },
    ).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(SearchSuccessState());
    });
  }
}

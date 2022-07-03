
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/search/cubit/states.dart';
import 'package:new_app/shared/network/end_points.dart';

import '../../../models/search_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(InitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel?searchModel;


  search({
    required String text,
  }){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token:token,
        data: {
          'text':text,
        }
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}
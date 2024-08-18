import 'package:stadium_app_task/src/core/api/api.dart';
import 'package:stadium_app_task/src/core/api/api_contstans.dart';
import 'package:stadium_app_task/src/data/model/stadium_model.dart';
import 'package:stadium_app_task/src/data/repository/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  @override
  Future<List<StadiumModel>?> getStadiumList() async {
    String? json = await DioService.request(
      ApiConstants.apiGetStadiumList,
      RequestMethod.GET,
    );

    if (json != null) {
      return stadiumModelFromJson(json);
    } else {
      return null;
    }
  }
}

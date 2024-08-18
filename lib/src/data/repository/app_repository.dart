import 'package:stadium_app_task/src/data/model/stadium_model.dart';

abstract class AppRepository {
  Future<List<StadiumModel>?> getStadiumList();
}

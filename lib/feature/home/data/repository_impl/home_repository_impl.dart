import 'package:furniture_app/feature/home/data/remote_data/home_remote_data.dart';
import 'package:furniture_app/feature/home/domian/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeRemoteData homeRemoteData;
  HomeRepositoryImpl({required this.homeRemoteData});
}
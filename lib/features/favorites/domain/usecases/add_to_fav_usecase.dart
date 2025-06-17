import 'package:cakes_store_frontend/features/favorites/domain/repository/base_fav_repo.dart';

class AddToFavUsecase {
  final BaseFavRepo _repo;
  AddToFavUsecase(this._repo);
  Future<void>? addToFav(String productId, String userId) {
    try {
      return _repo.addToFav(productId, userId);
    } catch (e) {
      print('error in usecase');
      return null;
    }
  }
}

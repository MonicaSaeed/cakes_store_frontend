import 'package:cakes_store_frontend/features/favorites/domain/repository/base_fav_repo.dart';

class RemoveFromFavUsecase {
  final BaseFavRepo _repo;
  RemoveFromFavUsecase(this._repo);
  Future<void>? removeFromFav(String productId, String userId) {
    try {
      // print('from usecase');
      // print('productId: $productId, userId: $userId');
      return _repo.removeFromFav(productId, userId);
    } catch (e) {
      print('error in usecase');
      return null;
    }
  }
}

import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/favorites/domain/repository/base_fav_repo.dart';
import 'package:cakes_store_frontend/features/favorites/domain/usecases/add_to_fav_usecase.dart';
import 'package:cakes_store_frontend/features/favorites/domain/usecases/get_all_favs_usecase.dart';
import 'package:cakes_store_frontend/features/favorites/domain/usecases/remove_from_fav_usecase.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavState> {
  final String? userId;

  FavCubit({this.userId}) : super(const FavInitial());

  List<ProductModel> favouritesProducts = [];
  loadAllFavourites() async {
    print('Loading all favourites for userId: $userId');
    emit(FavLoading());
    try {
      favouritesProducts =
          await GetAllFavsUsecase(sl<BaseFavRepo>()).getAllFavs(userId!) ?? [];
      emit(FavLoaded(favProducts: favouritesProducts));
    } catch (e) {
      print('Error loading favourites: $e');
      emit(FavError(errorMessage: e.toString()));
    }
  }

  toggleFavourite({required String productId}) async {
    // Implement the toggle favorite functionality
    // print('Toggling favorite for productId: $productId');
    // print('userId: $userId');
    print('Toggling favorite for productId: $productId');
    print('userId: $userId');
    if (state is! FavLoaded) return;
    try {
      favouritesProducts =
          await GetAllFavsUsecase(sl<BaseFavRepo>()).getAllFavs(userId!) ?? [];
      if (favouritesProducts.any((product) => product.id == productId)) {
        await RemoveFromFavUsecase(
          sl<BaseFavRepo>(),
        ).removeFromFav(productId, userId!);
        favouritesProducts.removeWhere((product) => product.id == productId);
      } else {
        await AddToFavUsecase(sl<BaseFavRepo>()).addToFav(productId, userId!);
        final updatedFavs = await GetAllFavsUsecase(
          sl<BaseFavRepo>(),
        ).getAllFavs(userId!);
        favouritesProducts = updatedFavs ?? favouritesProducts;
      }
      emit(FavLoaded(favProducts: favouritesProducts));
    } catch (e) {
      print('Error toggling favorite: $e');
      emit(FavError(errorMessage: e.toString()));
    }
  }
}

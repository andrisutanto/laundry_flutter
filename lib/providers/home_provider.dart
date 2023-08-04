import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_flutter/models/shop_model.dart';

import '../models/promo_model.dart';

//state provider untuk data yang simple dan tunggal, misal string, boolean, etc
//sedangkan untuk list atau object, menggunakan State Notifier

//untuk state category tab
final homeCategoryProvider = StateProvider.autoDispose((ref) => 'All');

//untuk state status loading promo
final homePromoStatusProvider = StateProvider.autoDispose((ref) => '');

//untuk state status loading recommendation
final homeRecommendationStatusProvider = StateProvider.autoDispose((ref) => '');

setHomeCategory(WidgetRef ref, String newCategory) {
  ref.read(homeCategoryProvider.notifier).state = newCategory;
}

setHomePromoStatus(WidgetRef ref, String newStatus) {
  ref.read(homePromoStatusProvider.notifier).state = newStatus;
}

setHomeRecommendationStatus(WidgetRef ref, String newStatus) {
  ref.read(homeRecommendationStatusProvider.notifier).state = newStatus;
}

// -----------------------------------------------------------------------------

//initial data for home promo
final homePromoListProvider =
    StateNotifierProvider.autoDispose<HomePromoList, List<PromoModel>>(
        (ref) => HomePromoList([]));

class HomePromoList extends StateNotifier<List<PromoModel>> {
  HomePromoList(super.state);

  setData(List<PromoModel> newData) {
    state = newData;
  }
}

// initial data for recommendation
final homeRecommendationListProvider =
    StateNotifierProvider.autoDispose<HomeRecommendationList, List<ShopModel>>(
        (ref) => HomeRecommendationList([]));

class HomeRecommendationList extends StateNotifier<List<ShopModel>> {
  HomeRecommendationList(super.state);

  setData(List<ShopModel> newData) {
    state = newData;
  }
}

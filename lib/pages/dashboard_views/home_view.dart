import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_flutter/config/failure.dart';
import 'package:laundry_flutter/datasources/promo_datasource.dart';
import 'package:laundry_flutter/datasources/shop_datasource.dart';
import 'package:laundry_flutter/models/promo_model.dart';
import 'package:laundry_flutter/models/shop_model.dart';

import '../../providers/home_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  getPromo() {
    PromoDatasource.readLimit().then((value) {
      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              setHomePromoStatus(ref, 'Server Error');
              break;
            case NotFoundFailure:
              setHomePromoStatus(ref, 'Error Not Found');
              break;
            case ForbiddenFailure:
              setHomePromoStatus(ref, 'You dont have access');
              break;
            case BadRequestFailure:
              setHomePromoStatus(ref, 'Bad Request');
              break;
            case UnauthorisedFailure:
              setHomePromoStatus(ref, 'Unauthorised');
              break;
            default:
              setHomePromoStatus(ref, 'Request Error');
              break;
          }
        },
        (result) {
          setHomePromoStatus(ref, 'Success');
          List data = result['data'];
          List<PromoModel> promos =
              data.map((e) => PromoModel.fromJson(e)).toList();
          ref.read(homePromoListProvider.notifier).setData(promos);
        },
      );
    });
  }

  getRecommendation() {
    ShopDatasource.readRecommendationLimit().then((value) {
      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              setHomeRecommendationStatus(ref, 'Server Error');
              break;
            case NotFoundFailure:
              setHomeRecommendationStatus(ref, 'Error Not Found');
              break;
            case ForbiddenFailure:
              setHomeRecommendationStatus(ref, 'You dont have access');
              break;
            case BadRequestFailure:
              setHomeRecommendationStatus(ref, 'Bad Request');
              break;
            case UnauthorisedFailure:
              setHomeRecommendationStatus(ref, 'Unauthorised');
              break;
            default:
              setHomeRecommendationStatus(ref, 'Request Error');
              break;
          }
        },
        (result) {
          setHomeRecommendationStatus(ref, 'Success');
          List data = result['data'];
          List<ShopModel> shops =
              data.map((e) => ShopModel.fromJson(e)).toList();
          ref.read(homeRecommendationListProvider.notifier).setData(shops);
        },
      );
    });
  }

  //saat init state, panggil getPromo dan getRecommendation
  @override
  void initState() {
    getPromo();
    getRecommendation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

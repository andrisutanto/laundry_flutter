import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_flutter/config/failure.dart';
import 'package:laundry_flutter/config/nav.dart';
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
  static final edtSearch = TextEditingController();

  gotoSearchCity() {}

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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              const SizedBox(
                height: 6,
              ),
              subtitle(),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Colors.green,
                        size: 20,
                      ),
                      DView.spaceWidth(4),
                      Text(
                        'Find By City',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Intrinsic Height ini digunakan agar row mengikuti row yang paling tinggi
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => gotoSearchCity(),
                                  icon: const Icon(Icons.search),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: edtSearch,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search...',
                                    ),
                                    onSubmitted: (value) => gotoSearchCity(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        DButtonElevation(
                          onClick: () {},
                          mainColor: Colors.green,
                          splashColor: Colors.greenAccent,
                          width: 50,
                          radius: 10,
                          child: const Icon(
                            Icons.tune,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget title() {
    return Text(
      'We\'re ready',
      style: GoogleFonts.ptSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget subtitle() {
    return Text(
      'to clean your clothes',
      style: GoogleFonts.ptSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1,
      ),
    );
  }
}

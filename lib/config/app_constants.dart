import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const appName = 'Laundry';

  static const _host = 'http://192.168.0.102:8000';

  // ``` base URL ```
  static const baseURL = '$_host/api';
  static const baseImageURL = '$_host/storage';

  static const laundryStatusCategory = [
    'All',
    'Pickup',
    'Queue',
    'Process',
    'Washing',
    'Dried',
    'Ironed',
    'Done',
    'Delivery'
  ];

  static List<Map> navMenuDashboard = [
    {
      'view': DView.empty('Home'),
      // 'view': Container(
      //   color: Colors.amber,
      // ),
      'icon': Icons.home_filled,
      'label': 'Home',
    },
    {
      'view': DView.empty('My Laundry'),
      'icon': Icons.local_laundry_service,
      'label': 'My Laundry',
    },
    {
      'view': DView.empty('Account'),
      'icon': Icons.account_circle,
      'label': 'Account',
    },
  ];
}

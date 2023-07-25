class AppConstants {
  static const appName = 'Laundry';

  static const _host = 'http://192.168.0.55';

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
}

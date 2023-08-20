class ApiConst {
  ApiConst._();

  // Base URL for API
  static const String apiKey = '';
  static const String baseUrl = 'https://trainee.landa.id/javacode';

  // Auth
  static const String login = '$baseUrl/auth/login';

  // Home
  static const String allPromo = '$baseUrl/promo/all';
  static const String allPromoPerUser = '$baseUrl/promo/user';
  static const String detailPromo = '$baseUrl/promo/detail';
  static const String allMenu = '$baseUrl/menu/all';
  static const String detailMenu = '$baseUrl/menu/detail';

  /// Cart
  static const String allDiscountPerUser = '$baseUrl/diskon/user';
  static const String allVoucherPerUser = '$baseUrl/voucher/user';

  /// Order
  static const String addOrder = '$baseUrl/order/add';
  static const String onGoingOrder = '$baseUrl/order/user';
  static const String historyOrder = '$baseUrl/order/history';
  static const String detailOrder = '$baseUrl/order/detail';
  static const String cancelOrder = '$baseUrl/order/batal';

  /// Profile
  static const String detailUser = '$baseUrl/user/detail';
  static const String updateUser = '$baseUrl/user/update';
  static const String updateUserPhoto = '$baseUrl/user/profil';
  static const String updateUserKTP = '$baseUrl/user/ktp';

  /// Review
  static const String allReview = '$baseUrl/review';
  static const String addReview = '$baseUrl/review/add';

  /// Firebase Cloud Messaging
  static const String firebaseCloudMessaging = 'https://fcm.googleapis.com/fcm/send';
}

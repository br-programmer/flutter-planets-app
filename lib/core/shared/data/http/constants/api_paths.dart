class APIPaths {
  const APIPaths._();
  static const String all = '/planets';
  static String byId(String id) => '$all/$id';
}

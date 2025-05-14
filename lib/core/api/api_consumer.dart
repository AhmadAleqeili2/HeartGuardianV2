abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Object? data,
    bool isFromData = false,
  });
  Future<dynamic> post(
    String path, {
    Object? data,
    bool isFromData = false,
  });
  Future<dynamic> put(
    String path, {
    Object? data,
    bool isFromData = false,
  });
  Future<dynamic> delete(
    String path, {
    Object? data,
    bool isFromData = false,
  });
}

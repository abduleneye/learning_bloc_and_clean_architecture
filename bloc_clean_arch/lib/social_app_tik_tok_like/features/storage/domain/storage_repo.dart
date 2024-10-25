import 'dart:typed_data';

abstract class StorageRepo {
  // upload profile images on a mobile platform
  Future<String?> uploadProfileImagesMobile(String path, String fileName);

  // upload profile images on a web platform
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);

  // upload profile images on a mobile platform
  Future<String?> uploadPostImagesMobile(String path, String fileName);

  // upload profile images on a web platform
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName);
}

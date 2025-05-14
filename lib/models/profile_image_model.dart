import 'dart:typed_data';

class ProfileImageModel {
  Uint8List image;
ProfileImageModel({
    required this.image,
  });



    factory ProfileImageModel.setImage(Uint8List image) {
    return ProfileImageModel(
      image: image,
    );
  }
}
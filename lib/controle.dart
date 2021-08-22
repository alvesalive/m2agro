import 'package:flutter/cupertino.dart';
import 'package:m2agro//comunicacao.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var imageURL = '';
  var respo = '';

  void uploadImage(ImageSource imageSource) async {
    try {
      final pickedFile = await ImagePicker().getImage(source: imageSource);
      isLoading(true);
      if (pickedFile != null) {
        var response = await ImageService.uploadFile(pickedFile.path);

        if (response.statusCode == 200) {
          //get image url from api response
          imageURL = response.data['user']['image'];
          respo = response.data['labelName']['labelId']['confidence'];

          Get.snackbar('OK', 'Imagem enviada',
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        } else if (response.statusCode == 401) {
          Get.offAllNamed('/sign_up');
        } else {
          Get.snackbar('erro', 'Erro : ${response.statusCode}',
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        }
      } else {
        Get.snackbar('erro', 'Image nao selecionada',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } finally {
      isLoading(false);
    }
  }
}

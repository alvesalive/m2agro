import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ImageService {
  static Future<dynamic> uploadFile(filePath) async {
    //jwt authentication token
    var authToken =
        'vm0qe6bopnzihw9i6cs63u0nqrkx28ttnutp6mj6bhmvvbygy2my3e80mc0nlemg';
    var authority = 'https://www.nyckel.com';
    //user im use to upload image
    //Note: this authToken and user id parameter will depend on my backend api structure
    //in your case it can be only auth token
    var _userId = 'ik7y4m14p86oc6dycn6bjuugd7ktavkc';

    try {
      FormData formData = new FormData.fromMap(
          {"image": await MultipartFile.fromFile(filePath, filename: "dp")});

      Response response = await Dio()
          .put("https://www.nyckel.com/v1/functions/bkxrtsa32yucxuaj/invoke",
          data: formData,
          options: Options(headers: <String, String>{
            'Authorization': 'Bearer $authToken',
          }));
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {}
  }
}

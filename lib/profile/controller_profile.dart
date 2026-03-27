import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/profile/model_profile.dart';

class ControllerProfile extends GetxController {
  ProfileV2 profile = ProfileV2();

  List<String> nnlts = [
    "Tiếng Việt",
    "No Language",
    "JAVA",
    "C++",
    "C#",
    "Python"
  ];

  bool edittable = false;
  static ControllerProfile get instance => Get.put(ControllerProfile());

  @override
  void onReady() {
    super.onReady();
    ProfileV2_Snapshot.loadProfile().then(
        (value){
          profile = value;
          update(["profile"]);
        }
    );
  }

  void changeState(){
    update(["profile"]);
  }

  void allowEdit(){
    edittable = true;
    update(["profile"]);
  }

  void save() async {
    ProfileV2_Snapshot.saveProfile(profile).then(
        (value){
          edittable = false;
          update(["profile"]);
        },
    );
  }
}
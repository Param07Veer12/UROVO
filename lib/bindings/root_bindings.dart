import 'package:get/get.dart';
import '../controllers/bottombar_controller.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(() => HomepageController());
    
  
  }
}
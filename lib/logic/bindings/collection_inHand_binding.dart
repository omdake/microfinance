import 'package:get/get.dart';
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandController.dart';


class CollectionInhandBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(CollectionInHandController());
   }
}
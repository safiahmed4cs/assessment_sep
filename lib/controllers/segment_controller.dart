import 'package:get/get.dart';

class SegmentController extends GetxController {
  var selectedSegment = 0.obs;

  void setSelectedSegment(int index) {
    selectedSegment.value = index;
  }
}

import 'package:get/get.dart';

class SegmentController extends GetxController {
  var selectedSegment = 0.obs;

  // this is to set the selected segment
  void setSelectedSegment(int index) {
    selectedSegment.value = index;
  }
}

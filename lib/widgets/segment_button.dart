import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assessment_sep_2024/controllers/segment_controller.dart';

class SegmentButton extends StatelessWidget {
  final String text;
  final int index;
  final SegmentController segmentController = Get.find();

  SegmentButton({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          segmentController.setSelectedSegment(index);
        },
        child: Obx(() {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: segmentController.selectedSegment.value == index
                  ? Colors.blue
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: segmentController.selectedSegment.value == index
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

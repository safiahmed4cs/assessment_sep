import 'package:assessment_sep_2024/controllers/topup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  TopUpController get topUpController => Get.find<TopUpController>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int totalCount = topUpController.allHistory.length;
      if (totalCount == 0) {
        return const Center(
          child: Text(
            'No history found.',
            style: TextStyle(fontSize: 14),
          ),
        );
      }

      // Set the initial scroll position to the end of the list
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });

      return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        reverse: true,
        itemCount: totalCount,
        itemBuilder: (context, index) {
          final history = topUpController.allHistory[index];
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: index == 0 ? 8 : 4,
              right: index == totalCount - 1 ? 8 : 4,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            history.nickname,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'AED ${history.amount}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          history.fullName,
                        ),
                        Text(
                          history.phoneNumber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class ReviewKostUser extends StatefulWidget {
  const ReviewKostUser({super.key, required this.kostId});

  final kostId;
  @override
  State<ReviewKostUser> createState() => _ReviewKostUserState();
}

class _ReviewKostUserState extends State<ReviewKostUser> {
  final KostController _kostController = Get.put(KostController());
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Review Kost'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _kostController.getReviewKostData(widget.kostId),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length > 0) {
              return RefreshIndicator(
                key: _refreshKey,
                onRefresh: () async {
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      setState(() {});
                    },
                  );
                },
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[index];
                    var date = DateTime.parse(data['created_at']);
                    var convertDate =
                        DateFormat('d MMMM yyyy', "id_ID").format(date);
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['user']['name'].toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 3),
                            RatingBar.builder(
                              allowHalfRating: false,
                              itemSize: 15,
                              itemPadding: const EdgeInsets.only(right: 4),
                              itemCount: 5,
                              initialRating: data['grade'].toDouble(),
                              direction: Axis.horizontal,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: const Color(0xFFFFB82E),
                              ),
                              ignoreGestures: true,
                              onRatingUpdate: (value) {},
                            ),
                            const SizedBox(height: 3),
                            const Divider(),
                            const SizedBox(height: 3),
                            Text(data['komentar'],
                                style: const TextStyle(color: Colors.black54)),
                            const SizedBox(height: 3),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(convertDate,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 10,
                                      color: Colors.black54)),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text('Belum ada review'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(
              child: Text('Error: Terjadi kesalahan'),
            );
          }
        },
      ),
    );
  }
}

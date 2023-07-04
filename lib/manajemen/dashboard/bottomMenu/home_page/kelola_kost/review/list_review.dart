import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class ListReviewKost extends StatefulWidget {
  const ListReviewKost({super.key, required this.kost});

  final kost;
  @override
  State<ListReviewKost> createState() => _ListReviewKostState();
}

class _ListReviewKostState extends State<ListReviewKost> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  final KostController _kostController = Get.put(KostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: const Color(0xFFFFB82E),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Review Kost',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(15),
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () async {
                await Future.delayed(
                  const Duration(),
                  () {
                    setState(() {});
                  },
                );
              },
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: _kostController.getReviewKostData(widget.kost),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = snapshot.data[index];
                            var date = DateTime.parse(data['created_at']);
                            var convertDate =
                                DateFormat('d MMMM yyyy', "id_ID").format(date);
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['user']['name'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: RatingBar.builder(
                                        itemCount: 5,
                                        minRating: 1,
                                        initialRating: data['grade'].toDouble(),
                                        itemSize: 15,
                                        allowHalfRating: false,
                                        direction: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: const Color(0xFFFFB82E),
                                        ),
                                        ignoreGestures: true,
                                        onRatingUpdate: (value) {
                                          print(value);
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    const Divider(),
                                    const SizedBox(height: 3),
                                    Text(data['komentar'],
                                        style: const TextStyle(
                                            color: Colors.black54)),
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
                        );
                      } else {
                        return const Center(
                          child: Text('Tidak Ada Review'),
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(
                          child: Text('Error: terjadi kesalahan'));
                    }
                  },
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

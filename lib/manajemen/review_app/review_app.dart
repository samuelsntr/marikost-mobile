import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/general_controller.dart';

class ReviewApp extends StatefulWidget {
  const ReviewApp({super.key, required this.idUser});

  final idUser;
  @override
  State<ReviewApp> createState() => _ReviewAppState();
}

class _ReviewAppState extends State<ReviewApp> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GeneralController _generalController = Get.put(GeneralController());

  var rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Review App',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('Beri Peringkat:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: const Color(0xFFFFB82E),
                      ),
                      itemCount: 5,
                      minRating: 1,
                      maxRating: 5,
                      direction: Axis.horizontal,
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Komentar:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'komentar',
                      maxLines: 3,
                      decoration: const InputDecoration(
                          hintText: 'Komentar', border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Wajib diisi!')
                      ]),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onPressed: () async {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            var val = _formKey.currentState!.value;
                            var check = await _generalController
                                .checkReview(widget.idUser);

                            if (check.length > 0) {
                              Get.dialog(AlertDialog(
                                title: const Text('Peringatan'),
                                content: const Text(
                                    'Anda tidak bisa menambahkan komentar lagi!'),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              ));
                            } else {
                              _generalController.rateOurApp(
                                  val, rating, widget.idUser);
                            }
                          }
                        },
                        child: const Text('Beri Review App')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

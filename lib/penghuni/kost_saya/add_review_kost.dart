import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class AddReviewKost extends StatefulWidget {
  const AddReviewKost({super.key, required this.kost});

  final kost;
  @override
  State<AddReviewKost> createState() => _AddReviewKostState();
}

class _AddReviewKostState extends State<AddReviewKost> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final KostController _kostController = Get.put(KostController());

  var rating = 0.0;

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
                    'Tambah Review Kost',
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
            child: SingleChildScrollView(
                child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Beri Peringkat:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Komentar',
                        border: OutlineInputBorder()),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Wajib diisi!')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          var val = _formKey.currentState!.value;
                          _kostController.addReview(widget.kost['kost']['id'],
                              widget.kost['id_penghuni'], rating, val);
                        }
                      },
                      child: const Text('Beri Review Kost')),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';

class EditAkun extends StatefulWidget {
  const EditAkun({super.key, required this.profil});

  final profil;
  @override
  State<EditAkun> createState() => _EditAkunState();
}

class _EditAkunState extends State<EditAkun> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AkunController _akunController = Get.put(AkunController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit Akun'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Foto Profil',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            FormBuilderImagePicker(
              imageQuality: 40,
              name: 'foto_profile',
              initialValue: widget.profil['foto_profil'] != null
                  ? [
                      'https://api.marikost.com/storage/users/${widget.profil['foto_profil']}'
                    ]
                  : null,
              decoration: const InputDecoration(
                  labelText: 'Foto Profile', border: OutlineInputBorder()),
              maxImages: 1,
            ),
            const SizedBox(height: 30),
            const Text('Data Diri',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Text('Nama:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            FormBuilderTextField(
              name: 'name',
              initialValue: widget.profil['name'],
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Nama User',
                  border: OutlineInputBorder()),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(errorText: 'Wajib diisi!')]),
            ),
            const SizedBox(height: 20),
            const Text('Jenis Kelamin:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            FormBuilderDropdown(
              name: 'jenis_kelamin',
              initialValue: widget.profil['jenis_kelamin'] == 'Perempuan'
                  ? 'Perempuan'
                  : 'Laki - Laki',
              items: const [
                DropdownMenuItem(
                    value: 'Laki - Laki', child: Text('Laki - Laki')),
                DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
              ],
              decoration: const InputDecoration(
                  hintText: 'Jenis Kelamin', border: OutlineInputBorder()),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(errorText: 'Wajib diisi!')]),
            ),
            const SizedBox(height: 20),
            const Text('Email:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            FormBuilderTextField(
              name: 'email',
              initialValue: widget.profil['email'],
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Email',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            const Text('No. Handphone:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            FormBuilderTextField(
              name: 'no_handphone',
              initialValue: widget.profil['no_handphone'],
              keyboardType: TextInputType.phone,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(errorText: 'Wajib diisi!')]),
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'No Handphone',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            if (widget.profil['nama_bank'] != null)
              const Text('Nama Bank:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            if (widget.profil['nama_bank'] != null)
              FormBuilderTextField(
                name: 'nama_bank',
                initialValue: widget.profil['nama_bank'],
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Nama Bank',
                    border: OutlineInputBorder()),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!')
                ]),
              ),
            const SizedBox(height: 20),
            if (widget.profil['no_bank'] != null)
              const Text('No. Rekening:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            if (widget.profil['no_bank'] != null)
              FormBuilderTextField(
                name: 'no_bank',
                initialValue: widget.profil['no_bank'],
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'No. Rekening',
                    border: OutlineInputBorder()),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!')
                ]),
              ),
            const SizedBox(height: 20),
            const Text('Password Baru:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            FormBuilderTextField(
              name: 'password',
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Password Baru',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                onPressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    var data = _formKey.currentState!.value;
                    _akunController.editUserAkun(data, widget.profil['id']);
                  }
                },
                child: const Text('Edit Profil')),
          ]),
        ),
      )),
    );
  }
}

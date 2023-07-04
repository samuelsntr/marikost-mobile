import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MariHelp extends StatelessWidget {
  const MariHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('MariHelp'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text('Jika mengalami masalah dan memerlukan bantuan?'),
            const SizedBox(height: 10),
            const Text('Hubungi Kontak kami dibawah ini:'),
            Card(
                elevation: 2,
                child: ListTile(
                  onTap: () {},
                  leading: const CircleAvatar(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    child: FaIcon(FontAwesomeIcons.whatsapp),
                  ),
                  title: const Text('WhatsApp'),
                  subtitle: const Text(
                      'Hubungi Customer service kami lewat akun WhatsApp '),
                  trailing: const Icon(Icons.chevron_right),
                )),
            const SizedBox(height: 10),
            Card(
                elevation: 2,
                child: ListTile(
                  onTap: () {},
                  leading: const CircleAvatar(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    child: FaIcon(FontAwesomeIcons.envelope),
                  ),
                  title: const Text('Hubungi Melalui Email'),
                  subtitle:
                      const Text('Hubungi Customer service kami melalui email'),
                  trailing: const Icon(Icons.chevron_right),
                )),
            const SizedBox(height: 10),
            Card(
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/help_desk');
                  },
                  leading: const CircleAvatar(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    child: FaIcon(FontAwesomeIcons.headset),
                  ),
                  title: const Text('Pusat Bantuan'),
                  subtitle: const Text('Panduan pengguna'),
                  trailing: const Icon(Icons.chevron_right),
                )),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

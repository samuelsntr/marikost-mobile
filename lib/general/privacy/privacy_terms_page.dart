import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marikost/general/privacy/privacy.dart';
import 'package:marikost/general/privacy/terms.dart';

class PrivacyTermsPage extends StatefulWidget {
  const PrivacyTermsPage({super.key});

  @override
  State<PrivacyTermsPage> createState() => _PrivacyTermsPageState();
}

class _PrivacyTermsPageState extends State<PrivacyTermsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'Privasi'),
          Tab(text: 'Syarat & Ketentuan')
        ]),
      ),
      body: TabBarView(
          controller: _tabController,
          children: <Widget>[PrivacyPage(), TermsPage()]),
    );
  }
}

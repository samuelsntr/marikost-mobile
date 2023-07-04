import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MariBayarList extends StatefulWidget {
  const MariBayarList({super.key});

  @override
  State<MariBayarList> createState() => _MariBayarListState();
}

class _MariBayarListState extends State<MariBayarList> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MariBayar')),
      body: RefreshIndicator(
          key: _refreshKey,
          onRefresh: () async {
            Future.delayed(
              const Duration(seconds: 2),
              () {
                setState(() {});
              },
            );
          },
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: const Text('Kost Oyo Denpasar'),
                subtitle: const Text('jl. Letda'),
                trailing: Chip(label: const Text('Belum Bayar')),
              );
            },
            itemCount: 2,
          )),
    );
  }
}

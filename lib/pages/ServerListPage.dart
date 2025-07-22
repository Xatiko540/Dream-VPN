import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/OpenVpnConfig.dart';
import '../model/UserPreference.dart';

class ServerListPage extends StatefulWidget {
  const ServerListPage({Key? key}) : super(key: key);

  @override
  State<ServerListPage> createState() => _ServerListPageState();
}

class _ServerListPageState extends State<ServerListPage> {
  late Future<List<OpenVpnConfig>> futureConfigs;

  @override
  void initState() {
    super.initState();
    futureConfigs = fetchOpenVpnConfigs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Выбор VPN сервера')),
      body: FutureBuilder<List<OpenVpnConfig>>(
        future: futureConfigs,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final configs = snapshot.data!;
          return ListView.builder(
            itemCount: configs.length,
            itemBuilder: (context, index) {
              final config = configs[index];
              return ListTile(
                title: Text(config.country),
                subtitle: Text(config.name),
                trailing: Icon(Icons.vpn_lock),
                onTap: () async {
                  final response = await http.get(Uri.parse(config.url));
                  final ovpn = utf8.decode(response.bodyBytes);
                  await Provider.of<UserPreference>(context, listen: false)
                      .connectWithConfig(ovpn);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;




class OpenVpnConfig {
  final String name;
  final String country;
  final String url;

  OpenVpnConfig({required this.name, required this.country, required this.url});
}




Future<List<OpenVpnConfig>> fetchOpenVpnConfigs() async {
  final response = await http.get(Uri.parse('https://openproxylist.com/openvpn/'));
  final document = parser.parse(response.body);
  final rows = document.querySelectorAll('table tr');

  final configs = <OpenVpnConfig>[];

  for (var row in rows.skip(1)) {
    final cols = row.querySelectorAll('td');
    if (cols.length < 5) continue;

    final country = cols[0].text.trim();
    final name = cols[1].text.trim();
    final downloadAnchor = cols[cols.length - 1].querySelector('a');

    if (downloadAnchor == null) continue;

    final href = downloadAnchor.attributes['href'];
    if (href == null || !href.endsWith('.ovpn')) continue;

    configs.add(OpenVpnConfig(
      name: name,
      country: country,
      url: 'https://openproxylist.com$href',
    ));
  }

  return configs;
}
import 'dart:convert';

import 'package:http/http.dart' as http;

class Apihelper {
  Apihelper._();
  static final Apihelper apihelper = Apihelper._();

  Future<Map?> getdata(
      {required String from,
      required String to,
      required String amount}) async {
    String api =
        "https://currency-converter-by-api-ninjas.p.rapidapi.com/v1/convertcurrency?have=$from&want=$to&amount=$amount";
    Uri uri = Uri.parse(api);
    http.Response res = await http.get(uri, headers: {
      'X-RapidAPI-Key': '93b04adbd2msh2005fe9359c3580p10860djsnfb821cf505b9',
      'X-RapidAPI-Host': 'currency-converter-by-api-ninjas.p.rapidapi.com'
    });
    if (res.statusCode == 200) {
      String Jasondata = res.body;
      Map data = jsonDecode(Jasondata);

      return data;
    }
    return null;
  }
}

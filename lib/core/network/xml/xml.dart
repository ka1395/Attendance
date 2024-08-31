import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

Future soapPost({String? url, String? soapRequest, String? soapAction}) async {
  // Send the request
  final response = await http.post(
    Uri.parse(url!),
    headers: {
      'Content-Type': 'text/xml; charset=utf-8',
      'SOAPAction': soapAction!,
    },
    body: soapRequest,
  );

  if (response.statusCode == 200) {
    // The response is XML, so we'll return it for parsing
    final responseXml = response.body;
    final myTransformer = Xml2Json();
    // Parse the response XML
    myTransformer.parse(responseXml);
    Map json = jsonDecode(myTransformer.toOpenRally()) as Map;
    return json;
  } else {
    return {"error": "NO data"};
  }
}

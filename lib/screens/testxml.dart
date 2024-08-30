import 'package:attendance/core/network/xml.dart';
import 'package:flutter/material.dart';

class XmlRequest extends StatefulWidget {
  const XmlRequest({super.key});

  @override
  State<XmlRequest> createState() => _XmlRequestState();
}

class _XmlRequestState extends State<XmlRequest> {
  String valueRespons = "sadas";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          valueRespons,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await soapPost(
                url: 'http://www.dneonline.com/calculator.asmx',
                soapRequest: '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Divide xmlns="http://tempuri.org/">
      <intA>5</intA>
      <intB>5</intB>
    </Divide>
  </soap:Body>
</soap:Envelope>''',
                soapAction: 'http://tempuri.org/Divide')
            .then(
          (value) {
            valueRespons =
                value['Envelope']['Body']['DivideResponse']['DivideResult'];
          },
        );
        setState(() {});
      }),
    );
  }
}

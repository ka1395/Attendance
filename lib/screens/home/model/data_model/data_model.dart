import 'data.dart';

class DataModel {
  String? status;
  Data? data;

  DataModel({this.status, this.data});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        status: json['status'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}

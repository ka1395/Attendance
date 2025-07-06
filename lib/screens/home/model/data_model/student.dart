class Student {
  String? id;
  String? name;
  String? image;
  String? type;
  String? checkInTime;
  bool? isAttend;

  Student(
      {this.id,
      this.name,
      this.image,
      this.type,
      this.checkInTime,
      this.isAttend});

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'] as String?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        type: json['type'] as String?,
        checkInTime: json['checkInTime'] ??"-- --:--",
        isAttend: json['isAttend'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'type': type,
        'checkInTime': checkInTime,
        'isAttend': isAttend ?? false,
      };
}

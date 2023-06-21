import 'package:equatable/equatable.dart';

class Users with EquatableMixin {
  Users({
    this.id,
    this.name,
    this.eposta,
    this.birthDate,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String?,
      name: json['name'] as String?,
      eposta: json['eposta'] as String?,
      birthDate: json['birthDate'] as String?,
    );
  }
  String? id;
  String? name;
  String? eposta;
  String? birthDate;

  @override
  List<Object?> get props => [id, name, eposta, birthDate];

  Users copyWith({
    String? id,
    String? name,
    String? eposta,
    String? birthDate,
  }) {
    return Users(
      id: id ?? this.id,
      name: name ?? this.name,
      eposta: eposta ?? this.eposta,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'eposta': eposta,
      'birthDate': birthDate,
    };
  }
}

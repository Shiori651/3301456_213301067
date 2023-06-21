import 'package:equatable/equatable.dart';

class Version with EquatableMixin {
  Version({
    this.number,
    this.store,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      number: json['number'] as String?,
      store: json['store'] as String?,
    );
  }
  String? number;
  String? store;

  @override
  List<Object?> get props => [number, store];

  Version copyWith({
    String? number,
    String? store,
  }) {
    return Version(
      number: number ?? this.number,
      store: store ?? this.store,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'store': store,
    };
  }
}

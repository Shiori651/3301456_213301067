class Library {
  Library({
    this.library,
    this.readList,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      library:
          (json['library'] as List<dynamic>?)?.map((e) => e as String).toList(),
      readList: (json['readList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
  List<String>? library;
  List<String>? readList;

  Library copyWith({
    List<String>? library,
    List<String>? readList,
  }) {
    return Library(
      library: library ?? this.library,
      readList: readList ?? this.readList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'library': library,
      'readList': readList,
    };
  }

  @override
  String toString() => "Library(library: $library,readList: $readList)";

  @override
  int get hashCode => Object.hash(library, readList);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Library &&
          runtimeType == other.runtimeType &&
          library == other.library &&
          readList == other.readList;
}

class League {
  final String? id;
  final String name;
  final String acronym;
  final String? code;

  League({this.id, required this.name, required this.acronym, this.code});

  /// Constructs a League from a Firestore document.
  factory League.fromFirestore(String docId, Map<String, dynamic> data) {
    return League(
      id: docId,
      name: data['name'] as String,
      acronym: data['acronym'] as String,
      code: data['code'] as String?,
    );
  }

  /// Existing fromJson for backward compatibility or testing.
  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] as String?,
      name: json['name'] as String,
      acronym: json['acronym'] as String,
      code: json['code'] as String?,
    );
  }

  /// Serializes to a Map for Firestore document data.
  /// Excludes `id` because Firestore manages document IDs separately.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'name': name, 'acronym': acronym};
    if (code != null) {
      map['code'] = code;
    }
    return map;
  }
}

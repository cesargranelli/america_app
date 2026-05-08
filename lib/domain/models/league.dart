class League {
  final String? id;
  final String name;
  final String acronym;
  final String foundationDate;

  League({
    this.id,
    required this.name,
    required this.acronym,
    required this.foundationDate,
  });

  factory League.fromFirestore(String docId, Map<String, dynamic>? data) {
    return League(
      id: docId,
      name: data!['name'] as String,
      acronym: data['acronym'] as String,
      foundationDate: data['foundationDate'] as String,
    );
  }

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] as String?,
      name: json['name'] as String,
      acronym: json['acronym'] as String,
      foundationDate: json['foundationDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'name': name,
      'acronym': acronym,
      'foundationDate': foundationDate,
    };

    return map;
  }
}

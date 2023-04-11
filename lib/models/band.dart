class Band {
  String? id;
  String? name;
  int? votes; 
  
  factory Band.fromMap(Map<String, dynamic> obj) => Band(
    id: obj.containsKey('id') ? obj['id'] : 'no-id',
    name: obj['name'],
    votes: obj['votes'],
  );

  Band({
    this.id, 
    this.name,
    this.votes
  });

}
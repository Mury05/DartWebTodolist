// Classe pour le type de données Todo
class Task {
  int id;
  String description;
  bool statut;

  Task(this.description) : id = DateTime.now().millisecondsSinceEpoch, statut = false;

  // Méthode pour convertir une tâche en map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'statut': statut,
    };
  }

  // Méthode statique pour créer une tâche depuis une map
  // static Task fromJson(Map<String, dynamic> json) {
  //   Task task = Task(json['description']);
  //   task.id = json['id'];
  //   task.statut = json['statut'];
  //   return task;
  // }

  static Task fromJson(Map<String, dynamic> json) {
  return Task(json['description'])..id = json['id']..statut = json['statut'];
}

}

import 'dart:convert';
import 'dart:html';
import '../task/task.dart';

class TodoList {
  List<Task> tasksList = [];

  // Fonction pour récupérer la liste des todos
  List<Task> getTasksList() {
    loadTodosFromStorage();
    return tasksList;
  }

  // Fonction pour ajouter un todo
  void addTask(String description) {
    if (description.isNotEmpty && description.trim() != "") {
      Task newTask = Task(description);
      getTasksList().add(newTask);
      saveTodosInStorage();
      print("Tâche ajoutée avec succès !");
    } else {
      print("La description de la tâche ne peut pas être vide !");
    }
  }

  // Fonction pour supprimer un todo
  void deleteTask(int id) {
    loadTodosFromStorage();
    Task? checkTask;
    for (Task task in getTasksList()) {
      if (task.id == id) {
        checkTask = task;
        break;
      }
    }

    if (checkTask != null) {
      tasksList.remove(checkTask);
      saveTodosInStorage();
      print("Tâche supprimée avec succès !");
    } else {
      print("Aucune tâche trouvée avec cet identifiant !");
    }
  }

  void deleteAllTask() {
    loadTodosFromStorage();
    tasksList.clear();
    saveTodosInStorage();
    print("Toutes les tâches ont été supprimées avec succès !");
  }

  // Fonction pour changer le statut d'une tâche
  void checkStatut(int id) {
    Task? checkTask;
    for (Task task in getTasksList()) {
      if (task.id == id) {
        checkTask = task;
        break;
      }
    }

    if (checkTask != null) {
      checkTask.statut = !checkTask.statut;
      saveTodosInStorage();
      print("Statut de la tâche modifié avec succès !");
    } else {
      print("Aucune tâche trouvée avec cet identifiant !");
    }
  }

  // Fonction pour modifier une tâche
  void editTask(int id, String newDescription) {
    Task? checkTask;
    for (Task task in getTasksList()) {
      if (task.id == id) {
        checkTask = task;
        break;
      }
    }

    if (checkTask != null) {
      checkTask.description = newDescription;
      saveTodosInStorage();
      print("Tâche modifiée avec succès !");
    } else {
      print("Aucune tâche trouvée avec cet identifiant !");
    }
  }

  // Fonction pour afficher une tâche spécifique
  void showTask(int id) {
    Task? checkTask;
    for (Task task in getTasksList()) {
      if (task.id == id) {
        checkTask = task;
        break;
      }
    }

    if (checkTask != null) {
      print(
          "Tâche n°${checkTask.id} : ${checkTask.description} - Statut : ${checkTask.statut ? "Terminée" : "En cours"} ");
    } else {
      print("Aucune tâche trouvée avec cet identifiant !");
    }
  }

  // Fonction pour afficher toutes les tâches
  void showAllTasks() {
    if (getTasksList().isNotEmpty) {
      for (Task task in getTasksList()) {
        print(
            "Tâche n°${task.id} : ${task.description} - Statut : ${task.statut ? "Terminée" : "En cours"} ");
      }
    } else {
      print("Aucune tâche trouvée !");
    }
  }

 // Fonction pour sauvegarder les tâches dans localStorage
  void saveTodosInStorage() {
    window.localStorage['todos'] = jsonEncode(tasksList.map((task) => task.toJson()).toList());
  }

  // Fonction pour charger les tâches depuis localStorage
  void loadTodosFromStorage() {
    String? storedData = window.localStorage['todos'];
    if (storedData != null) {
      List<dynamic> jsonList = jsonDecode(storedData);
      tasksList = jsonList.map((json) => Task.fromJson(json)).toList();
    } else {
      tasksList = [];
    }
  }
}

// Mise en place de TodolistConsole avec Dart

import 'dart:convert';
import 'dart:io';
import '../task/task.dart';

class TodoList {
  List<Task> tasksList = [];

  // Fonction pour récupérer la liste des todos
  List<Task> getTasksList() {
    loadTodosFromFile();
    return tasksList;
  }

  // Fonction pour ajouter un todo
  void addTask(String description) {
    if (description.isNotEmpty && description.trim() != "") {
      Task newTask = Task(description);
      getTasksList().add(newTask);
      saveTodosInFile();
      print("Tâche ajoutée avec succès !");
    } else {
      print("La description de la tâche ne peut pas être vide !");
    }
  }

  // Fonction pour supprimer un todo
  void deleteTask(int id) {
    loadTodosFromFile();
    Task? checkTask;
    for (Task task in getTasksList()) {
      if (task.id == id) {
        checkTask = task;
        break;
      }
    }

    if (checkTask != null) {
      tasksList.remove(checkTask);
      saveTodosInFile();
      print("Tâche supprimée avec succès !");
    } else {
      print("Aucune tâche trouvée avec cet identifiant !");
    }
  }

  void deleteAllTask() {
    loadTodosFromFile();
    tasksList.clear();
    saveTodosInFile();
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
      saveTodosInFile();
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
      saveTodosInFile();
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

  // void saveTodosInFile() {
  //   File file = File('todos.txt');
  //   file.writeAsStringSync(jsonEncode(tasksList));
  // }

  // void loadTodosFromFile() {
  //   File file = File('todos.txt');
  //   if (file.existsSync()) {
  //     String content = file.readAsStringSync();
  //     tasksList = List<Task>.from(jsonDecode(content));
  //   } else {
  //     tasksList = [];
  //   }
  // }

  // Mettre en place le système de fichiers pour la sauvegarde des todos
  void saveTodosInFile() {
    File file = File('todos.txt');
    List<Map<String, dynamic>> jsonList =
        tasksList.map((task) => task.toJson()).toList();
    file.writeAsStringSync(jsonEncode(jsonList), mode: FileMode.write);
  }

  // Récupérer la liste des todos depuis le fichier
  void loadTodosFromFile() {
    File file = File('todos.txt');
    if (file.existsSync()) {
      String content = file.readAsStringSync();
      List<dynamic> jsonList = jsonDecode(content);
      tasksList = jsonList.map((json) => Task.fromJson(json)).toList();
    } else {
      tasksList = [];
    }
  }
}

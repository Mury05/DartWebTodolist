import 'package:web/web.dart' as web;
import 'features/todolist/dart_todolist.dart';
import 'features/task/task.dart';
import 'dart:html' as web; // Importation correcte pour la manipulation du DOM

void main() {
//  final mainContent = web.document.querySelector('#main') as web.DivElement;

  // Créer une instance de TodoList
  TodoList todoList = TodoList();

  addFeatures(todoList);

  display(todoList);
}

void addFeatures(TodoList todoList) {
  // Sélectionner le formulaire d'ajout de tâche
  final submitTodo = web.document.querySelector('#myForm') as web.FormElement;

  // Ajouter un écouteur d'événement pour la soumission du formulaire
  submitTodo.addEventListener('submit', (event) {
    event.preventDefault(); // Empêcher le rechargement de la page

    // Récupérer la valeur de l'input
    final newTask = web.document.querySelector('#task') as web.InputElement?;
    if (newTask != null &&
        newTask.value != null &&
        newTask.value!.trim().isNotEmpty) {
      todoList.addTask(newTask.value!.trim()); // Ajouter la tâche
      display(todoList);
      newTask.value = ''; // Réinitialiser l'input
    } else {
      print("Veuillez entrer une tâche valide.");
    }
  });
}

void display(TodoList todoList) {
  final container =
      web.document.getElementById('todo-list') as web.HTMLDivElement;

  container.text = "";

  final tasksList = todoList.getTasksList();

  for (Task task in tasksList) {
    final li = web.document.createElement('li');
    li.className =
        'py-4 px-2 my-4 mx-2 rounded-md transition ease-in-out delay-150 break-all cursor-pointer ${task.statut ? 'bg-green-200 line-through' : 'bg-blue-300'}';

    // Ajouter du texte
    final textNode = web.document.createTextNode(task.description);

    li.appendChild(textNode);

    // Ajouer l'élement à la liste
    container.appendChild(li);
  }
}

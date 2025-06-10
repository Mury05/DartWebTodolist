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

  // Vider le container avant de ré-afficher la liste
  container.text = "";

  final tasksList = todoList.getTasksList();

  // Checkbox pour supprimer toutes les tasks
  final checkBoxAll = web.document.createElement('input') as web.InputElement;
  checkBoxAll.type = "checkbox";
  checkBoxAll.className = "mx-2 cursor-pointer";
  checkBoxAll.onChange.listen((event) {
    todoList.deleteAllTask();
    display(todoList); // Rafraîchir l'affichage
  });
  container.append(checkBoxAll as web.Node);

  for (Task task in tasksList) {
    final li = web.document.createElement('li') as web.HTMLLIElement;
    li.className =
        'py-4 px-2 my-4 mx-2 rounded-md flex items-center justify-between transition ease-in-out delay-150 break-all cursor-pointer ${task.statut ? 'bg-green-200 line-through' : 'bg-blue-300'}';

    // Checkbox pour changer le statut
    final checkBox = web.document.createElement('input') as web.InputElement;
    checkBox.type = "checkbox";
    checkBox.checked = task.statut;
    checkBox.className = "mr-2";
    checkBox.onChange.listen((event) {
      todoList.checkStatut(task.id!);
      display(todoList); // Rafraîchir l'affichage
    });

    // Texte de la tâche
    final textNode = web.document.createTextNode(task.description);

    // Conteneur des actions (Modifier / Supprimer)
    final divActions = web.document.createElement('div') as web.DivElement;
    divActions.className = 'flex gap-2';

    // Bouton Modifier
    final updateBtn = web.document.createElement('button') as web.ButtonElement;
    updateBtn.text = "✏️";
    updateBtn.className = "px-2 py-1 bg-yellow-400 rounded cursor-pointer";
    updateBtn.onClick.listen((event) {
      final modifTask =
          web.document.querySelector('#task') as web.InputElement;
      modifTask.value = task.description;
      
      String? newDescription =
          web.window.prompt("Modifier la tâche :", task.description);
      if (newDescription != null && newDescription.trim().isNotEmpty) {
        todoList.editTask(task.id!, newDescription.trim());
        display(todoList); // Rafraîchir l'affichage
      }
    });

    // Bouton Supprimer
    final deleteBtn = web.document.createElement('button') as web.ButtonElement;
    deleteBtn.text = "🗑️";
    deleteBtn.className =
        "px-2 py-1 bg-red-500 text-white rounded cursor-pointer";
    deleteBtn.onClick.listen((event) {
      todoList.deleteTask(task.id!);
      display(todoList); // Rafraîchir l'affichage
    });

    // Ajouter les boutons à la div actions
    divActions.append(updateBtn);
    divActions.append(deleteBtn);

    // Ajouter les éléments à la tâche (li)
    li.append(checkBox as web.Node);
    li.appendChild(textNode);
    li.append(divActions as web.Node);

    // Ajouter l'élément à la liste
    container.append(li);
  }
}

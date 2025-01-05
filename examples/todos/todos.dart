import "dart:html";

import "package:dartea/dartea.dart";

enum Priority {
    low,
    middle,
    high;
    
    static Priority fromString(String priority) {
        switch (priority) {
            case "low":
                return Priority.low;
            case "middle":
                return Priority.middle;
            case "high":
                return Priority.high;
            default:
                return Priority.low;
        } 
    }
}

class TodoData {
    final String name;
    final Priority priority;

    const TodoData(this.name, this.priority);
}

class Todo extends Component {
    final TodoData data;
    final Function() removeTodo;
    Todo(this.data, this.removeTodo); 

    @override
    Element? render() {
        return LIElement()
            ..className = "list-item ${data.priority.name}"
            ..append(DivElement()..text = data.name)
            ..append(
                ButtonElement()
                ..className = "btn square"
                ..text = "X"
                ..addEventListener("click", (e) => removeTodo())
            );
    }
}

class NewTodoForm extends Component {
    final Function(TodoData) addTodo;

    NewTodoForm(this.addTodo);

    @override
    Element? render() {
        return FormElement()
            ..className = "form"
            ..append(InputElement()..name = "name")
            ..append(
                SelectElement()..name = "priority"
                ..append(OptionElement(data: "low", value: "low", selected: true))
                ..append(OptionElement(data: "middle", value: "middle"))
                ..append(OptionElement(data: "high", value: "high"))
            )
            ..append(InputElement()..className = "btn big"..type = "submit"..value = "New Todo")
            ..addEventListener("submit", (e) {
                e.preventDefault();
                final target = e.target! as FormElement;
                FormData data = FormData(target);
                if ((data.get("name") as String?)?.isEmpty ?? false) return;
                addTodo(TodoData(data.get("name") as String, Priority.fromString(data.get("priority") as String)));
            });
    }
}

class AppState {
    final List<TodoData> todos = [
        TodoData("some todo", Priority.high),
        TodoData("another todo", Priority.low),
    ];
}

class App extends StatefulComponent<AppState> {
    App() : super(AppState());

    void removeTodo(int idx) {
        updateState(() {
            state.todos.removeAt(idx);
        });
    }

    void newTodo(todoData) {
        updateState(() {
            state.todos.add(todoData);
        });
    }

    @override
    Element? render() {
        final list = UListElement()..className = "list";

        for (final (idx, todoData) in state.todos.indexed) {
            list.mount(Todo(todoData, () => removeTodo(idx)));
        }

        return DivElement()
            ..className = "app"
            ..append(list)
            ..mount(NewTodoForm(newTodo));
    }
}

void main() {
    document.body!.mount(App());
}

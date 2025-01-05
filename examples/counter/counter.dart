import "dart:html";
import "package:dartea/dartea.dart";

class AppState {
    int count = 0;
}

class Counter extends Component {
    final int count;
    final void Function() inc;
    Counter({required this.count, required this.inc});

    @override
    Element render() {
        return ButtonElement()
            ..text = "$count"
            ..addEventListener("click", (e) => inc());
    }
}

class App extends StatefulComponent<AppState> {
    App() : super(AppState());

    @override
    Element? render() {
        return DivElement()
        ..className = "black"
        ..append(HeadingElement.h1()..text = "Counter")
        ..mount(Counter(count: state.count, inc: () => updateState(() { state.count += 1; })));
    }
}

void main() {
    document.body!.mount(App());
}

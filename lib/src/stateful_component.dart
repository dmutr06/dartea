import "dart:html";
import "./component.dart";

abstract class StatefulComponent<State> extends Component {
    State state;

    StatefulComponent(this.state) : super(); 

    // TODO: make normal refocus
    void _update() {
        final prevFocus = document.activeElement;
        final newElement = render();
        if (element != null && newElement != null) {
            element!.replaceWith(newElement);
        }
        element = newElement;

        prevFocus?.focus();
    }

    void updateState(void Function() fn) {
        fn();
        _update();
    }
}


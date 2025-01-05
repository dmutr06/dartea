import "dart:html";

abstract class Component {
    Element? element;

    Component();

    Element? render();

    void _mountTo(Element parent) {
        element = render();
        if (element != null) {
            parent.append(element!);
        }
    }
}

extension AppendComponent on Element {
    void mount(Component component) {
        component._mountTo(this);
    }
}

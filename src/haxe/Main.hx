package;

import js.html.Element;
import react.ReactDOMClient;

function main() {
    var rootElement = document.getElementById("root");
    var root = ReactDOMClient.createRoot(rootElement);

    root.render(
        jsx('
            <React.StrictMode>
                <App />
            </React.StrictMode>
        ')
    );
}
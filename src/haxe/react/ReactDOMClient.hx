package react;

import js.html.Element;

#if jsImport
@:js.import(@default "react-dom/client")
#else

#if (!react_global)
@:jsRequire("react-dom/client")
#end

@:native('ReactDOMClient')
#end
extern class ReactDOMClient {
    public static function createRoot(container:Element, ?options:Null<Dynamic>):Dynamic;
}
(function () {
    window.kentico.pageBuilder.registerInlineEditor("kentico-cloud-asset-selector", {
        init: function (options) {
            var editor = options.editor;

            var x = editor.querySelector("select");
            x.addEventListener("change", function () {
                // Creates a custom event that notifies the widget about a change in the value of a property
                var event = new CustomEvent("updateProperty", {
                    detail: {
                        value: x.value,
                        name: options.propertyName
                    }
                });
                editor.dispatchEvent(event);
            });
        }
    });
})();

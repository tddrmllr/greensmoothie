(function() {
  CKEDITOR.config.fontSize_sizes = '14/14px;18/18px;20/20px;24/24px';

  CKEDITOR.config.font_names = "Open Sans";

  CKEDITOR.config.font_style = {
    element: "span",
    styles: {
      "font-family": "Open Sans"
    },
    overrides: [
      {
        element: "font",
        attributes: {
          face: null
        }
      }
    ]
  };

  CKEDITOR.config.toolbar = [
    {
      name: "clipboard",
      groups: ["clipboard", "undo"],
      items: ["Cut", "Copy", "Paste", "PasteText", "PasteFromWord", "-", "Undo", "Redo"]
    }, {
      name: "editing",
      groups: ["find", "selection", "spellchecker"],
      items: ["Find", "Replace", "-", "SelectAll", "-", "Scayt"]
    }, {
      name: "basicstyles",
      groups: ["basicstyles", "cleanup"],
      items: ["Bold", "Italic", "Underline", "Strike", "Subscript", "Superscript", "-", "RemoveFormat"]
    }, {
      name: "paragraph",
      groups: ["list", "indent", "blocks", "align", "bidi"],
      items: ["NumberedList", "BulletedList", "-", "Outdent", "Indent", "-", "Blockquote", "-", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock"]
    }, {
      name: "insert",
      items: ["Image", "Table", "HorizontalRule", "SpecialChar", "PageBreak"]
    }, "/", {
      name: "styles",
      items: ["Styles", "Format", "FontSize"]
    }, {
      name: "colors",
      items: ["TextColor", "BGColor"]
    }, {
      name: "tools",
      items: ["Maximize"]
    }
  ];

  CKEDITOR.editorConfig = function(config) {
    config.language = 'en';
    config.contentsCss = "/assets/application.css";
    config.bodyClass = 'cke-contents';
    config.startupFocus = true;
    config.allowedContent = true;
    return config.width = '100%';
  };

}).call(this);

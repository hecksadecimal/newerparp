import { Controller } from "@hotwired/stimulus"
import { RhinoStarterKit } from "rhino-editor/exports/extensions/rhino-starter-kit"

function placeCaretAtEnd(el) {
  el.focus();
  if (typeof window.getSelection != "undefined"
          && typeof document.createRange != "undefined") {
      var range = document.createRange();
      range.selectNodeContents(el);
      range.collapse(false);
      var sel = window.getSelection();
      sel.removeAllRanges();
      sel.addRange(range);
  } else if (typeof document.body.createTextRange != "undefined") {
      var textRange = document.body.createTextRange();
      textRange.moveToElementText(el);
      textRange.collapse(false);
      textRange.select();
  }
}

// Connects to data-controller="wysiwyg"
export default class extends Controller {
  connect() {
    document.addEventListener("rhino-before-initialize", (e) => {
      const rhinoEditor = e.target
      rhinoEditor.autofocus = true;
      
      rhinoEditor.starterKitOptions = { 
        ...rhinoEditor.starterKitOptions,
        rhinoGallery: false,
        codeBlock: false,
        blockquote: false,
        code: false,
        increaseIndentation: false,
        decreaseIndentation: false
      }
      rhinoEditor.rebuildEditor()
    })

    document.addEventListener("rhino-initialize", (e) => {
      const rhinoEditor = e.target
      let editorSlot = rhinoEditor.querySelectorAll('[slot="editor"]')[0]
      placeCaretAtEnd(editorSlot)

      rhinoEditor.addEventListener("keydown", (e) => {
        if (e.key == "Enter" && !e.ctrlKey) {
          let submitSlot = rhinoEditor.querySelectorAll('[slot="toolbar-end"]')
          if (submitSlot) {
            e.preventDefault()
            console.log(submitSlot[0])

            submitSlot[0].click()
          }
        }
      }, true)

    })
  }
}

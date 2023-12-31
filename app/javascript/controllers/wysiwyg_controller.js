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
        bulletList: false,
        orderedList: false,
        increaseIndentation: false,
        decreaseIndentation: false
      }
      rhinoEditor.rebuildEditor()
    })

    document.addEventListener("rhino-initialize", (e) => {
      const rhinoEditor = e.target
      let editorSlot = rhinoEditor.querySelectorAll('[slot="editor"]')[0]
      placeCaretAtEnd(editorSlot)

      let toggleSlot = rhinoEditor.querySelectorAll('[slot="toolbar-start"]')
      var currentPath = window.location.href.substring(window.location.href.lastIndexOf('/') + 1)
      window.paraMode = +window.localStorage.getItem("paragraph_"+currentPath)

      if (toggleSlot) {
        toggleSlot[0].checked = paraMode
        toggleSlot[0].addEventListener("change", (e) => {
          window.paraMode = !window.paraMode
          window.localStorage.setItem("paragraph_"+currentPath, +window.paraMode)
        })
      }

      rhinoEditor.addEventListener("keydown", (e) => {
        if (e.key == "Enter") {
          if (window.paraMode) {
            if (e.shiftKey) {
              let submitSlot = rhinoEditor.querySelectorAll('[slot="toolbar-end"]')
              if (submitSlot) {
                e.preventDefault()
                submitSlot[0].click()
              }
            }
          } else {
            console.log(paraMode)
            let submitSlot = rhinoEditor.querySelectorAll('[slot="toolbar-end"]')
            if (submitSlot) {
              e.preventDefault()
              submitSlot[0].click()
            }
          }
        }
      }, true)

    })
  }
}

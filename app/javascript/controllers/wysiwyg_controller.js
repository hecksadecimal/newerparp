import { Controller } from "@hotwired/stimulus"
import { RhinoStarterKit } from "rhino-editor/exports/extensions/rhino-starter-kit"

// Connects to data-controller="wysiwyg"
export default class extends Controller {
  connect() {
    document.addEventListener("rhino-before-initialize", (e) => {
      const rhinoEditor = e.target
      rhinoEditor.starterKitOptions = { ...rhinoEditor.starterKitOptions, rhinoFocus: true, rhinoGallery: false }
      rhinoEditor.rebuildEditor()
    })

    document.addEventListener("rhino-initialize", (e) => {
      const rhinoEditor = e.target
      //rhinoEditor.commands.focus('end')
    })
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wysiwyg"
export default class extends Controller {
  connect() {
    document.addEventListener("rhino-before-initialize", (e) => {
      console.log("Initializing WYSIWYG")
      const rhinoEditor = e.target
      //rhinoEditor.extensions = [subScript, superScript]
      // configuring the starter kit
      rhinoEditor.starterKitOptions = { ...rhinoEditor.starterKitOptions, rhinoGallery: false }
    })
  }
}

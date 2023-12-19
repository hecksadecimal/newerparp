import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cssinject"
export default class extends Controller {
  connect() {
    console.log("Injecting CSS into tinymce")
    window.setTimeout(() => {
      window.tinymce.activeEditor.on("init", () => {
        let iframe = window.tinymce.activeEditor.iframeElement;
        if (iframe) {
          const cssLink = document.head.getElementsByTagName("link")[0];
          const cssClone = cssLink.cloneNode(false)
          iframe.contentWindow.document.head.appendChild(cssClone);
        }
      })
    }, 300)
  }
}

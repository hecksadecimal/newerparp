import { Controller } from "@hotwired/stimulus"
import chroma from "chroma-js"

// Connects to data-controller="colouradjust"
export default class extends Controller {
  connect() {
    var allElements = this.element.getElementsByTagName("*")

    for (var i=0, max=allElements.length; i < max; i++) {
      var cssObj = window.getComputedStyle(allElements[i], null)
      var colour = cssObj.getPropertyValue('color')
      var ch
      if (chroma.valid(colour)) {
        ch = chroma(colour)
        console.log(ch)

      } else {
        console.log(colour)
        if (colour.startsWith("oklch")) {

        }
      }
    }
  }
}

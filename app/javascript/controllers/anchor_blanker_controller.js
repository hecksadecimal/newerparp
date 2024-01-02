import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="anchor-blanker"
export default class extends Controller {
  connect() {
    this.element.querySelectorAll('a').forEach(function(link) {
      if (link.target != "_blank") {
        link.target = "_blank"
      }
    })
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autoscroll"
export default class extends Controller {
  connect() {
    window.setTimeout(() => {
      this.element.lastElementChild.scrollIntoView(false);
    }, 500)

    this.element.addEventListener(
      "DOMNodeInserted",
      (event) => {
        window.setTimeout(() => {
          var scrollPercentage = 100 * this.element.scrollTop / (this.element.scrollHeight-this.element.clientHeight); 
          if (scrollPercentage > 50) {
            this.element.scrollTop = this.element.scrollHeight;
          }
        }, 500)
      },
      false,
    );
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autoscroll"
export default class extends Controller {
  connect() {
    this.element.scrollTo(0, this.element.scrollHeight);
    this.element.addEventListener(
      "DOMNodeInserted",
      (event) => {
        var scrollVal = this.element.scrollHeight - this.element.scrollTop - this.element.clientHeight;
        if (scrollVal < 30) {
          this.element.scrollTo(0, this.element.scrollHeight);
        }
      },
      false,
    );
  }
}

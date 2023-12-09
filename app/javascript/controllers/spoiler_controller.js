import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spoiler"
export default class extends Controller {
  connect() {
    this.element.querySelector('input[type=checkbox]').addEventListener('change', (event) => {
      if (!event.currentTarget.checked) {
        this.element.querySelectorAll('.spoiler-on').forEach((item) => {
          item.classList.add("hidden")
        })
        this.element.querySelectorAll('.spoiler-off').forEach((item) => {
          item.classList.remove("hidden")
        })
      } else {
        this.element.querySelectorAll('.spoiler-on').forEach((item) => {
          item.classList.remove("hidden")
        })
        this.element.querySelectorAll('.spoiler-off').forEach((item) => {
          item.classList.add("hidden")
        })
      }
    })
  }
}

import { Controller } from "@hotwired/stimulus"
import { themeChange } from 'theme-change'

// Connects to data-controller="theme-select"
export default class extends Controller {
  connect() {
    themeChange(false)
  }
}

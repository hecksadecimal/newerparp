import { Controller } from "@hotwired/stimulus"

let resetFunc;
let timer = 0;

let prevAction = ""

// Connects to data-controller="presence"
export default class extends Controller {

  connect() {
    resetFunc = () => this.resetTimer(this.uninstall);
    this.install();
    this.typingInstall();
    window.addEventListener("turbo:load", () => this.resetTimer());

  }

  disconnect() {
    this.uninstall();
  }


  online() {
    this.perform("online");
  }

  idle() {
    this.perform("idle");
  }

  offline() {
    this.perform("offline");
  }

  typingInstall() {
    let rich_editor = document.getElementsByTagName('rhino-editor')[0];
    console.log(rich_editor)
    if (!!rich_editor) {
      rich_editor.addEventListener("rhino-focus", resetFunc);
      rich_editor.addEventListener("rhino-change", resetFunc);
    }
  }

  install() {
    window.removeEventListener("load", resetFunc);
    window.removeEventListener("DOMContentLoaded", resetFunc);
    window.removeEventListener("click", resetFunc);
    window.removeEventListener("keydown", resetFunc);

    window.addEventListener("load", resetFunc);
    window.addEventListener("DOMContentLoaded", resetFunc);
    window.addEventListener("click", resetFunc);
    window.addEventListener("keydown", resetFunc);

    this.resetTimer();
  }

  resetTimer() {
    this.uninstall();
    const shouldRun = document.getElementById("chat");

    if (!!shouldRun) {
      this.online();
      clearTimeout(timer);
      const timeInSeconds = 1;
      const milliseconds = 1000;
      const timeInMinutes = timeInSeconds * 60 * milliseconds;
      // Number of minutes to be delayed
      const numberOfMinutes = 1;
      const timeInMilliseconds = timeInMinutes * numberOfMinutes;

      timer = setTimeout(this.idle.bind(this), timeInMilliseconds);
    }
  }

  uninstall() {
    const shouldRun = document.getElementById("chat");
    if (!shouldRun) {
      clearTimeout(timer);
      this.perform("offline");
    }
  }

  perform(action) {
    if (action == prevAction) return;
    prevAction = action

    console.log(action)
    fetch(window.location.pathname + "/presence", {
      method: "PATCH",
      body: JSON.stringify({
        status: action,
        authenticity_token: document.getElementsByName('csrf-token')[0].content
      }),
      headers: {
        "Content-type": "application/json; charset=UTF-8"
      }
    });
  }


}

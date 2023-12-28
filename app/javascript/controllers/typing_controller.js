import { Controller } from "@hotwired/stimulus"

let resetTypingFunc;
let typingTimer = 1;
let typing = false
let firstRun = true
let init = 0

let prevAction = ""


// Connects to data-controller="typing"
export default class extends Controller {

  connect() {
    resetTypingFunc = () => this.resetTypingTimer(this.typingUninstall);
    this.typingInstall();
    window.addEventListener("turbo:load", () => this.resetTypingTimer());

  }

  disconnect() {
    this.typingUninstall();
  }

  beginTyping() {
    if (init < 2) {
      init++
      return
    }
    if (!typing) {
      typing = true;
      this.perform("beginTyping");
    }
  }

  stopTyping() {
    if (typing) {
      typing = false;
      this.perform("stopTyping");
    }
  }

  typingInstall() {
    let rich_editor = document.getElementsByTagName('rhino-editor')[0];
    if (!!rich_editor) {
      rich_editor.addEventListener("rhino-change", resetTypingFunc);
    }

    this.resetTypingTimer();
  }

  resetTypingTimer() {
    this.typingUninstall();
    const shouldRun = document.getElementById("chat");

    if (!!shouldRun) {
      if (!typing) {
        this.beginTyping();
      }
      clearTimeout(typingTimer);
      const timeInSeconds = 2;
      const milliseconds = 1000;
      const timeInMilliseconds = timeInSeconds * milliseconds;

      typingTimer = setTimeout(this.stopTyping.bind(this), timeInMilliseconds);
    }
  }

  typingUninstall() {
    const shouldRun = document.getElementById("chat");
    if (!shouldRun) {
      clearTimeout(typingTimer);
      if (typing) {
        this.perform("stopTyping");
      }
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

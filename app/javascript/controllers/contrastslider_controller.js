import { Controller } from "@hotwired/stimulus"

function onRangeChange(r,f) {
  var n,c,m;
  r.addEventListener("input",function(e){n=1;c=e.target.value;if(c!=m)f(e);m=c;});
  r.addEventListener("change",function(e){if(!n)f(e);});
}

function percentage(partialValue, totalValue) {
  return (100 * partialValue) / totalValue;
} 

// Connects to data-controller="contrastslider"
export default class extends Controller {
  static targets = [ "label", "input", "output" ]

  connect() {
    if (!window.localStorage) {
      this.inputTarget.disabled = true;
      return
    }

    var input = this.inputTarget
    var output = this.outputTarget
    var label = this.labelTarget

    var max = parseInt(input.max)

    let debounceTimer;
    let debounceTimerSave;
    const debounceSave = (callback, time) => {
      window.clearTimeout(debounceTimerSave);
      debounceTimerSave = window.setTimeout(callback, time);
    }
    const debounce = (callback, time) => {
      window.clearTimeout(debounceTimer);
      debounceTimer = window.setTimeout(callback, time);
    }
 
    onRangeChange(this.inputTarget, (e) => {
      label.innerHTML = percentage(input.value, max).toFixed(2) + "%"
      debounceSave(function(event, ui) {
        window.localStorage.setItem("minimum_contrast", input.value / 10)
        console.log("Saved value")
      }, 600)
      debounce(function(event, ui) {
        output.value = input.value / 10.0
        var event = new Event('change');
        output.dispatchEvent(event);
      }, 700)
    })


    var savedValue = window.localStorage.getItem("minimum_contrast")
    if (savedValue) {
      input.value = savedValue * 10
      label.innerHTML = percentage(input.value, max).toFixed(2) + "%"
      window.setTimeout(() => {
        output.value = input.value / 10.0
      }, 50)
    }
  }
}

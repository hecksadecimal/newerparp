import { Controller } from "@hotwired/stimulus"
import chroma from "chroma-js"

// Connects to data-controller="colouradjust"

function saveColours(elements) {
  for (var i=0, max=elements.length; i < max; i++) {
    if (elements[i].style.color) {
      elements[i].setAttribute("originalColor", elements[i].style.color)
    }
  }
}

function computeColours(elements) {
  var container = document.getElementById("container")
  var containerCssObj = window.getComputedStyle(container, null)
  var bgColour = containerCssObj.getPropertyValue('background-color')

  var total = 0

  var containerCh
  if (chroma.valid(bgColour)) {
    containerCh = chroma(bgColour)
  } else {
    if (bgColour.startsWith("oklch")) {
      var values = bgColour.replace("oklch(", "")
      values = values.replace(")", "")
      var components = values.split(" ")
      containerCh = chroma.oklch(parseFloat(components[0]), parseFloat(components[1]), parseFloat(components[2]))
    }
  }

  for (var i=0, max=elements.length; i < max; i++) {
    if (elements[i].getAttribute("originalColor")) {
      elements[i].style.color = elements[i].getAttribute("originalColor")
    } else {
      elements[i].style.color = null
    }

    var cssObj = window.getComputedStyle(elements[i], null)
    var colour = cssObj.getPropertyValue('color')

    var ch
    if (chroma.valid(colour)) {
      ch = chroma(colour) 
    } else {
      if (colour.startsWith("oklch")) {
        var values = colour.replace("oklch(", "")
        values = values.replace(")", "")
        var components = values.split(" ")
        ch = chroma.oklch(parseFloat(components[0]), parseFloat(components[1]), parseFloat(components[2]))
      }
    }

    var contrast = chroma.contrast(containerCh, ch)

    if (contrast < 5.5) {
      var colourScale = chroma.scale([ch.darken(2.5), ch, ch.brighten(2.5)]).gamma(0.5).colors(12);
      var sortedScale = colourScale.sort((a, b) => {
        var chA = chroma(a)
        var dist = chroma.distance(chA, ch)
        return dist
      })

      var testCh
      var selectedCh
      for (const colour of sortedScale) {
        testCh = chroma(colour)
        var testContrast = chroma.contrast(containerCh, testCh)
        if (testContrast >= 5.5) {
          selectedCh = testCh
          break
        }
      }
      if (selectedCh) {
        total += 1
        elements[i].style.color = selectedCh.css()
        if (elements[i].classList.contains("spoiler")) {
          elements[i].style.color = null
        }
      }
    }
  }
}

export default class extends Controller {
  connect() {
    var target = this.element
    var allElements = Array.prototype.slice.apply(target.querySelectorAll('*'))
    allElements.push(target)

    saveColours(allElements)
    computeColours(allElements)

    let options = {
      childList: false,
      attributes: true,
      characterData: false,
      subtree: false,
      attributeFilter: ['data-theme'],
      attributeOldValue: false,
      characterDataOldValue: false
    };

    let observer = new MutationObserver(callback);

    function callback (mutations) {
      allElements = Array.prototype.slice.apply(target.querySelectorAll('*'))
      allElements.push(target)
      computeColours(allElements)
    }
    
    observer.observe(document.documentElement, options);
  }
}

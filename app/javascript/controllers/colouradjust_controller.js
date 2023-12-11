import { Controller } from "@hotwired/stimulus"
import chroma from "chroma-js"

// Connects to data-controller="colouradjust"

function cssColorToRGBA(string) {
  const canvas = document.createElement("canvas");
  canvas.width = canvas.height = 1;
  const ctx = canvas.getContext("2d", {willReadFrequently: true});
  ctx.fillStyle = string;
  ctx.fillRect(0, 0, 1, 1);
  return ctx.getImageData(0, 0, 1, 1).data;
}

function getInheritedTextColor(el) {
  var defaultStyle = getDefaultTextColor()
  var color = window.getComputedStyle(el).color
  if (color != defaultStyle) return color
  if (!el.parentElement) return defaultStyle
  return getInheritedTextColor(el.parentElement)
}

function getInheritedBackgroundColor(el) {
  var defaultStyle = getDefaultBackground() 
  var backgroundColor = window.getComputedStyle(el).backgroundColor
  if (backgroundColor != defaultStyle) return backgroundColor
  if (!el.parentElement) return defaultStyle
  return getInheritedBackgroundColor(el.parentElement)
}

function getDefaultTextColor() {
  var div = document.createElement("div")
  document.head.appendChild(div)
  var bg = window.getComputedStyle(div).color
  document.head.removeChild(div)
  return bg
}

function getDefaultBackground() {
  var div = document.createElement("div")
  document.head.appendChild(div)
  var bg = window.getComputedStyle(div).backgroundColor
  document.head.removeChild(div)
  return bg
}
export default class extends Controller {
  connect() {
    var target = this

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
      target.computeColours()
    }
    this.saveColours()
    this.computeColours()

    observer.observe(document.documentElement, options);
  }

  saveColours() {
    let elems = this.element.querySelectorAll("*")
    for (let el of elems) {
      if (el.style.color) {
        el.originalcolor = el.style.color
      }
    }
  }

  resetColours() {
    let elems = this.element.querySelectorAll("*")
    for (let el of elems) {
      if (el.originalcolor) {
        el.style.color = el.originalcolor
      } else {
        el.style.color = null
      }
    }
  }

  computeColours() {
    const minContrast = 5.0
    //this.resetColours()
    let elems = this.element.querySelectorAll("*")

    let bgColor = cssColorToRGBA(getInheritedBackgroundColor(this.element))
    let bgCh = chroma.rgb(bgColor[0], bgColor[1], bgColor[2], bgColor[3])

    for (let el of elems) {
      if (el.originalcolor) {
        el.style.color = el.originalcolor
      } else {
        el.style.color = null
      }

      let color = cssColorToRGBA(getInheritedTextColor(el))
      let ch = chroma.rgb(color[0], color[1], color[2], color[3])
      let contrast = chroma.contrast(ch, bgCh)
      if (contrast < minContrast) {
        let palette = chroma.scale([ch.darken(2), ch, ch.brighten(1)]).correctLightness().colors(10)
        palette.sort((a, b) => {
          let ca = chroma(a)
          let cb = chroma(b)
          let diff = chroma.deltaE(ca, ch) - chroma.deltaE(cb, ch)
          return diff
        })

        let bestCh = ch
        for (const value of palette) {
          let newCh = chroma(value)
          let newContrast = chroma.contrast(newCh, bgCh)
          if (newContrast >= minContrast) {
            bestCh = newCh
            break
          }
        }
        el.style.color = bestCh.css()
      }
    }
  }
}

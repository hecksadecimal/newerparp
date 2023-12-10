import { Controller } from "@hotwired/stimulus"

// Text entry keyboard shortcuts
var ctrl_command = false;
var alt_command = false;
function insert_bbcode(target, initial, closing, is_attribute) {
  var len = target.value.length;
  var start = target.selectionStart;
  var end = target.selectionEnd;
  var selection = target.value.substring(start, end);
  var output = initial + selection + closing;
  target.value = target.value.substring(0, start) + output + target.value.substring(end, len);
  // if selection is empty, place caret within new tag
  if (selection.length == 0 && is_attribute == false) {
    target.selectionStart = start + initial.length;
    target.selectionEnd = start + initial.length;
  }
  // if we're inserting a tag with an attribute value, place cursor at hex/value position
  if (is_attribute == true) {
    target.selectionStart = start + initial.length - 1;
    target.selectionEnd = start + initial.length - 1;
  }
  ctrl_command = false;
  alt_command = false;
}

// Shortcut listener check; ctrl = 17; osx command = 91 (Safari), 224 (FF)			
function is_shortcut(e) {
  var target = e.target || e.srcElement;
  console.log(target)
  var keyLocation = ["Standard", "Left", "Right", "Numpad", "Mobile", "Joystick"][e.location];
  if (e.keyCode == 18 && keyLocation !== "Right") alt_command=true;
  if (e.keyCode == 17 || e.keyCode == 91 || e.keyCode == 224) ctrl_command=true;
  if (ctrl_command == true && alt_command == true){
    switch (e.keyCode) {
      case 13: // enter for br/newline
        insert_bbcode(target, "[br]", "", false);
        return true;
      case 74: // j for sup
      case 38: // up arrow for sup
        insert_bbcode(target, "[sup]", "[/sup]", false);
        return true;
      case 75: // k for sub
      case 40: // down arrow for sub
        insert_bbcode(target, "[sub]", "[/sub]", false);
        return true;
      case 66: // b for bold
        insert_bbcode(target, "[b]", "[/b]", false);
        return true;
      case 67: // c for caps
        insert_bbcode(target, "[c]", "[/c]", false);
        return true;
      case 70: // f for font 
        insert_bbcode(target, "[font=]", "[/font]", true);
        return true;
      case 71: // g for bgcolor (since b is taken)
        insert_bbcode(target, "[bgcolor=]", "[/bgcolor]", true);
        return true;
      case 72: // h for hex (since c is needed)
        insert_bbcode(target, "[color=]", "[/color]", true);
        return true;
      case 73: // i for italics
        insert_bbcode(target, "[i]", "[/i]", false);
        return true;
      case 76: // l for aLternian (since a is needed)
        insert_bbcode(target, "[alternian]", "[/alternian]", false);
        return true;
      case 79: // o for open/link (since u is underline)
        insert_bbcode(target, "[url=]", "[/url]", true);
        return true;
      case 80: // p for sPoiler (since s is strikethrough)
        insert_bbcode(target, "[spoiler]", "[/spoiler]", false);
        return true;
      case 82: // r for raw
        insert_bbcode(target, "[raw]", "[/raw]", false);
        return true;
      case 83: // s for strikethrough
        insert_bbcode(target, "[s]", "[/s]", false);
        return true;
      case 85: // u for underline
        insert_bbcode(target, "[u]", "[/u]", false);
        return true;
      case 87: // w for whisper
        insert_bbcode(target, "[w]", "[/w]", false);
        return true;
      case 190: // toggle preview on/off with "."
        $("#show_preview").click();
        return true;
    }
  }
  return false;
}

// Connects to data-controller="autofocus"
export default class extends Controller {
  
  connect() {
    this.element.focus();
    this.element.addEventListener("keyup", function(e) {
      alt_command = false;
      ctrl_command = false;
    });
    this.element.addEventListener("keydown", function(e) {
      // prevent default if we're actually using a shortcut
      if (is_shortcut(e)) {
        console.log(e)
        e.preventDefault();
        return false;
      }
    });
  }
}

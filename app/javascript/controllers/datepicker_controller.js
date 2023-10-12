import { Controller } from "@hotwired/stimulus"
import moment from "moment"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static values = {
    start: String,
    end: String
  }

  connect() {
    window.moment = moment
    console.log(this.startValue)
    new DateRangePicker(this.element, {
      startDate: this.startValue,
      endDate: this.endValue,
      minDate: this.startValue,
      maxDate: this.endValue,
      alwaysShowCalendars: true,
      autoApply: true,
      linkedCalendars: false,
      showDropdowns: true,
      ranges: {
          'Today': [moment().startOf('day'), moment().endOf('day')],
          'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
          'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
          'This Month': [moment().startOf('month').startOf('day'), moment().endOf('month').endOf('day')],
          'First Day': [this.startValue, this.startValue],
          'Most Recent Day': [this.endValue, this.endValue],
          'Everything': [this.startValue, this.endValue]
      },
      locale: {
          format: "YYYY-MM-DD HH:mm:ss",
      }
    })
  }
}

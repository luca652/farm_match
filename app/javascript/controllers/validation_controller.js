import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validation"
export default class extends Controller {
  static targets = ["numberField"]

  // // connect() {
  // //   this.numberFieldTarget.addEventListener("input", this.validate.bind(this));
  // // }

  // validatePresence(event) {
  //   const unit = event.target.value;

  //   if (unit = "- Select -") {
  //     event.target.setCustomValidity("You must select an option for Unit");
  //   }

  //   event.target.reportValidity();
  // }

  isPositiveInteger(event) {
    const value = event.target.value;
    const number = parseFloat(value);

    if (isNaN(number) || number < 0 || !Number.isInteger(number)) {
      event.target.setCustomValidity("Value must be a non-negative whole number.");
    } else {
      event.target.setCustomValidity("");
    }

    event.target.reportValidity();
  }
}

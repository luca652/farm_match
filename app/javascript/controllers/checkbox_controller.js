import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["checkbox"]

  consoleLogChecked(event) {
    console.log(event.currentTarget.checked)
  }

  preventEmptySubmission(event) {

    const checkboxes = this.checkboxTargets;
    const isChecked = checkboxes.some(checkbox => checkbox.checked);

    if (!isChecked) {
      event.preventDefault();
      alert("You must select at least one service.");
    }
  }
}

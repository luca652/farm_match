import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["valueField", "optionalField"]

  connect() {
    console.log("Question controller connected");
  }

  toggleOptionalField(event) {
    const selectedValue = event.target.value;
    const optionalField = this.optionalFieldTarget;
    const triggerValues = ["Other", "yes"];

    console.log(selectedValue)
    if (triggerValues.includes(selectedValue)) {
      optionalField.classList.remove("hidden");
    } else {
      optionalField.classList.add("hidden");
    }
  }

}

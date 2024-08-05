import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["valueField", "otherInput"]

  connect() {
    console.log("Question controller connected");
    this.toggleOtherField();
  }

  toggleOtherField(event) {
    const selectedValue = this.valueFieldTarget.value;
    const otherFormField = this.otherInputTarget;

    if (selectedValue === "Other") {
      otherFormField.classList.remove("hidden");
    } else {
      otherFormField.classList.add("hidden");
    }
  }

}

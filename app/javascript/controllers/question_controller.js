import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["valueField", "otherInput"]

  connect() {
    console.log("Question controller connected");
  }

  toggleOtherField(event) {
    const selectedValue = event.target.value;
    const otherFormField = this.otherInputTarget;


    console.log(selectedValue)
    if (selectedValue === "Other") {
      otherFormField.classList.remove("hidden");
    } else {
      otherFormField.classList.add("hidden");
    }
  }

}

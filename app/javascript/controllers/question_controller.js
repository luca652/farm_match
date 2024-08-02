import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["otherInput"]

  connect() {
    console.log("ciao!")

  }

  toggleOtherField(event) {
    const selectedValue = event.target.value;
    const otherFormField = this.otherInputTarget;

    if (selectedValue === "Other") {
      otherFormField.classList.remove("hidden");
      this.finalAnswerTarget.value = "";
    } else {
      otherFormField.classList.add("hidden");
      this.finalAnswerTarget.value = selectedValue;
    }
  }

  updateAnswer(event) {
    this.finalAnswerTarget.value = event.target.value;
  }
}

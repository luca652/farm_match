import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["other"]

  connect() {
    console.log("ciao!")

  }

  displayOther(event) {
    const choice = event.target.value;
    console.log(choice)
    const otherFormField = this.otherTarget;
    if (choice === "Other") {
      otherFormField.classList.remove("hidden");
    } else {
      otherFormField.classList.add("hidden");
    }

  }
}

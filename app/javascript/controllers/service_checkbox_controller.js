import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="service-checkbox"
export default class extends Controller {
  static targets = ["destroyInput"]
  connect() {
    console.log("ecchime!")
  }

  toggleDestroy(event) {
    const isChecked = event.target.checked;
    const destroyInput = this.destroyInputTarget;

    if (isChecked) {
      destroyInput.value = "0";
    } else {
      destroyInput.value = "1";
    }
  }
}

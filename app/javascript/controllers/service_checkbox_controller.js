import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="service-checkbox"
export default class extends Controller {
  static targets = ["destroyInput"]

  connect() {
    console.log("Service checkbox controller connected")
  }

  // existing services are pre-ticked in the view and are rendered with a _destroy input set to 0
  // when ticking or unticking a checkbos, this method is targeted and it:
  // - stores whethere the box is checked or not in isChecked (true/false)
  // - checks the markup for a destroyInputTarget (present only for existing, pre-ticked records)
  // - if the box is unticked, it marks it for destruction by setting the value to 1, if it is ticked again it returns it to 0.
  toggleDestroy(event) {
    const isChecked = event.target.checked
    if (this.hasDestroyInputTarget) {
      this.destroyInputTarget.value = isChecked ? "0" : "1"
    }
  }
}

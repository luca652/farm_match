import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["services"]
  static values = {
    url: String
  }

  connect() {
    console.log("Second controller connected!")
    this.element.addEventListener("subcategory-select", this.services.bind(this))
  }

  services(event) {
    let subcategory = event.detail.subcategory
    console.log("Subcategory selected:", subcategory)
    // Fetch services based on the selected subcategory
  }
}

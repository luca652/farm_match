import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["subcategory", "services"]
  static values = {
    url: String
  }

  subcategory(event) {
    let category = event.target.value
    let target = this.subcategoryTarget.id
    let url = this.urlValue

    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }

  subcategory_select() {
    console.log("triggered!")

    let subcategory = this.subcategoryTarget.value
    this.element.dispatchEvent(new CustomEvent("subcategory-select", { detail: { subcategory } }))

  }
}

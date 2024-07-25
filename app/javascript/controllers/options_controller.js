import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["category", "subcategory", "services", "servicesField"]
  static values = {
    subcategoriesUrl: String,
    servicesUrl: String
  }

  setOptionsForSubcategory(event) {
    let category = encodeURIComponent(event.target.value)
    let target = this.subcategoryTarget.id
    let url = this.subcategoriesUrlValue

    if (category === "") { return; }

    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }
}

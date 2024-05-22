import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["category", "subcategory"]
  static values = {
    url: String
  }

  connect() {
    let category = this.categoryTarget.value
    let target = this.subcategoryTarget.id
    let url = this.urlValue

    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }

  subcategory(event) {
    console.log("category: ", )
    let category = event.target.value
    let target = this.subcategoryTarget.id
    let url = this.urlValue

    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }
}

import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["subcategory"]
  static values = {
    url: String
  }

  change(event) {
    let category = event.target.value
    let target = this.subcategoryTarget.id
    let url = this.urlValue
    console.log("category: ", category)

    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }
}

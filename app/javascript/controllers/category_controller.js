import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["category", "subcategory", "services"]
  static values = {
    subcategoriesUrl: String,
    servicesUrl: String
  }

  setSubcategoryOptions(event) {

    let category = encodeURIComponent(event.target.value)
    let target = this.subcategoryTarget.id
    let url = this.subcategoriesUrlValue

    console.log(`${url}?target=${target}&category=${category}`)
    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }

  setServicesOptions(event) {
    let subcategory = encodeURIComponent(event.target.value)
    let target = this.servicesTarget.id
    let url = this.servicesUrlValue

    get(`${url}?target=${target}&subcategory=${subcategory}`, {
      responseKind: "turbo-stream"
    })
  }
}

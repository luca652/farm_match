import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["category", "subcategory", "services"]
  static values = {
    subcategoriesUrl: String,
    servicesUrl: String
  }

  // connect() {
  //   console.log(this.formBuilderValue)
  // }
  setSubcategoryOptions(event) {

    let category = encodeURIComponent(event.target.value)
    let target = this.subcategoryTarget.id
    let url = this.subcategoriesUrlValue

    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }

  setOptionsForServices(event) {
    let subcategory = encodeURIComponent(event.target.value)
    let target = this.servicesTarget.id
    let url = this.servicesUrlValue

    console.log("target: ", target)
    get(`${url}?target=${target}&subcategory=${subcategory}`, {
      responseKind: "turbo-stream"
    })
  }
}

import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["category", "subcategory", "followUp"]
  static values = {
    subcategoriesUrl: String,
    questionsUrl: String
  }

  connect() {
    console.log("options controller connected")
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

  setOptionsForQuestion(event) {
    let answer = event.target.value
    let target = this.followUpTarget.id
    let url = this.questionsUrlValue

    console.log("url: ", url)
    console.log("answer: ", answer)

    if (answer === "") { return; }

    get(`${url}?target=${target}&answer=${answer}`, {
      responseKind: "turbo-stream"
    })
  }
}

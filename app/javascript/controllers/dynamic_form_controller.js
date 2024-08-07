import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["category", "subcategory", "followUp", "wording", "valueField", "optionalField"]
  static values = {
    subcategoriesUrl: String,
    selectOptionsUrl: String
  }

  connect() {
    console.log("Dynamic Form Controller Connected");
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
    let url = this.selectOptionsUrlValue
    let questionWording = event.target.dataset.dynamicFormQuestionWording

    console.log("wording: ", questionWording)
    console.log("url: ", url)
    console.log("answer: ", answer)

    if (answer === "") { return; }

    get(`${url}?target=${target}&answer=${answer}&question_wording=${encodeURIComponent(questionWording)}`, {
      responseKind: "turbo-stream"
    })
  }

  toggleOptionalField(event) {
    const selectedValue = event.target.value;
    const optionalField = this.optionalFieldTarget;
    const triggerValues = ["Other", "Yes"];

    console.log(selectedValue)
    console.log("optional_field: ", optionalField)
    if (triggerValues.includes(selectedValue)) {
      optionalField.classList.remove("hidden");
    } else {
      optionalField.classList.add("hidden");
    }
  }
}

import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["category", "subcategory", "question", "selectFieldToUpdate", "wording", "optionalField", "otherField"]
  static values = {
    subcategoriesUrl: String,
    selectOptionsUrl: String
  }

  connect() {
    console.log("Dynamic Form Controller Connected");
  }

  setOptionsForSubcategory(event) {
  // This method is used in _form_step_one.html.erb to dynamically populate the subcategory select input based on user category selection.
    let category = encodeURIComponent(event.target.value)
    let target = this.subcategoryTarget.id
    let url = this.subcategoriesUrlValue

    if (category === "") { return; }

    get(`${url}?target=${target}&category=${category}`, {
      responseKind: "turbo-stream"
    })
  }


  setOptionsForQuestion(event) {
  // This method is used by questions with kind: :multiple_choice_with_effect_on_next
  // These questions update the options for select of the following question based on the user's answer

    // Here we are finding the next question, so that we can target it for updating.
    const nextQuestionElement = this.findNextQuestionElement(event.target);

    if (!nextQuestionElement) {
        console.warn("Next question element not found.");
        return;
    }

    // Here we target the select element specifically.
    // There's a selectFieldToUpdate data target on the select element of every multiple choice question,
    // so we have to find the element with the right index number.
    const nextQuestionIndex =  nextQuestionElement.dataset.questionIndex;
    const nextQuestionSelect = this.selectFieldToUpdateTargets.find(target => {
        return target.closest("[data-question-index]").dataset.questionIndex == nextQuestionIndex;
    });

    if (!nextQuestionSelect) {
        console.warn("Next question select not found.");
        return;
    }

    // We are fetching data from the server. Here we are defining the url, which directs to the options_for_questions action in the questions controller,
    // and we are passing it the user's answer, the target (the select input of the next question) and the current question's wording as key value pairs.
    // The controller retrieves the correct options from FOLLOW_UP_OPTIONS in the questionnaire_generator.
    let url = this.selectOptionsUrlValue;
    let answer = event.target.value;
    let questionWording = event.target.dataset.dynamicFormQuestionWording;

    if (answer === "") { return; }

    get(`${url}?target=${nextQuestionSelect.id}&answer=${answer}&question_wording=${encodeURIComponent(questionWording)}`, {
      responseKind: "turbo-stream"
    });
}

  toggleOptionalQuestion(event) {
  // This method is used by questions with kind: :multiple_choice_with_optional
  // These questions are always followed by a question with 'optional' set to true, which means that they are 'hidden' by default.
  // If the user selects certain trigger values, the optional question is revealed.

    const nextQuestionElement = this.findNextQuestionElement(event.target);

    if (!nextQuestionElement) {
        console.warn("Next question element not found.");
        return;
    }

    const selectedValue = event.target.value;
    const optionalField = nextQuestionElement;
    // At the moment the only trigger value is "Yes". Other trigger values can be added to the array.
    // Potential issues: this will work as long as the array is small and we don't expect the same words (e.g. "Yes"), to have different results for different questions.
    const triggerValues = ["Yes"];

    if (triggerValues.includes(selectedValue)) {
      optionalField.classList.remove("hidden");
    } else {
      optionalField.classList.add("hidden");
    }
  }


  toggleOtherField(event) {
  // This method is used by questions with kind: :multiple_choice_with_other.
  // The method reveals a text input when the user selects 'Other'.
  // NO NEED TO FIND NEXT QUESTION as this question is made up of two inputs (a multiple question input + a hidden text input)
    const selectedValue = event.target.value;
    const otherField = this.otherFieldTarget

    if (selectedValue === "Other") {
      otherField.classList.remove("hidden");
    } else {
      otherField.classList.add("hidden");
    }
  }


  findNextQuestionElement(currentElement) {
    const currentQuestionIndex = currentElement.closest("[data-question-index]").dataset.questionIndex;
    const nextQuestionIndex = parseInt(currentQuestionIndex) + 1;

    return this.questionTargets.find(target => {
      return target.dataset.questionIndex == nextQuestionIndex;
    });
  }
}

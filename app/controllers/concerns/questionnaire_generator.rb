module QuestionnaireGenerator
  extend ActiveSupport::Concern

  AREA_QUESTION = { kind: :area, wording: "Estimated number of acres/hectacres?", options: ["acres", "hectares"], answer_title: "Area"}
  DESCRIPTION_QUESTION = { kind: :description, wording: "Please write a short decription of the task", answer_title: "Description"}

  QUESTIONS = { 'Fertilizer Spreading' => [{ kind: :multiple_choice, wording: "What type of fertilizer do you want spread?", answer_title: "Type of fertilizer", options: ["granular", "liquid"]},
                                           AREA_QUESTION, DESCRIPTION_QUESTION],
                'Lime Spreading' => [{ kind: :multiple_choice, wording: "Do you need a loader?", options: ["yes", "no"], answer_title: "Loader"},
                                      AREA_QUESTION, DESCRIPTION_QUESTION],
                'Spraying (specialised)' => [{ kind: :multiple_choice, wording: "What type of spraying do you require?", answer_title: "Type of spraying", options: ["ATV spraying", "Avadex application", "Slug pelleting", "Weed wiping", "Other"]},
                                             AREA_QUESTION, DESCRIPTION_QUESTION],
                'Spraying (standard)' => [{ kind: :multiple_choice, wording: "What type of spraying do you require?", answer_title: "Type of spraying", options: ["Arable spraying", "Grassland spraying"]},
                                          AREA_QUESTION, DESCRIPTION_QUESTION],
                'Cereals - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: ["Any method", "Combi-drill", "Conventional", "Direct"]},
                                         AREA_QUESTION, DESCRIPTION_QUESTION],
                'Grass Seed - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: ["Any method", "Broadcast", "Cross Drilling", "Harrow"]},
                                            AREA_QUESTION, DESCRIPTION_QUESTION],
                'Maize - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: ["Precision", "Under film"]},
                                       AREA_QUESTION, DESCRIPTION_QUESTION],
                'Oil Seed Rape - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: [] },
                                               AREA_QUESTION, DESCRIPTION_QUESTION],
                'Potatoes - Drilling' => [AREA_QUESTION, DESCRIPTION_QUESTION],
                'Sugar Beet - Drilling' => [AREA_QUESTION, DESCRIPTION_QUESTION],
                'Vegetables - Drilling' => [{ kind: :multiple_choice_with_other, wording: "What type of vegetables are you sowing?", answer_title: "Type of vegetable", options: [ "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Kale", "Leek", "Lettuce", "Onion", "Peas", "Rhubarb", "Turnip", "Other"]},
                                            AREA_QUESTION, DESCRIPTION_QUESTION ],
                'Fence Erection' => [{ kind: :multiple_choice, wording: "What type of fence do you require?", answer_title: "Type of fence", collection: ["Post and four barb", "Post and three rails", "Post, stock, net and two barb"]},
                                     { kind: :short_length, wording: "Estimated length of mowing required? (Pick one measurement)", answer_title: "Estimated length", collection: ["Feet", "Meters", "Miles", "Kilometers"]}]

                }

  def generate_questions_for_service(service)
    QUESTIONS[service.name].map do |question_attrs|
      service.questions.build(question_attrs)
    end
  end
end

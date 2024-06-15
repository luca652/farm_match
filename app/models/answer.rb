class Answer < ApplicationRecord
  belongs_to :service

  validates :label, presence: true

  before_save :convert_and_store_area

  # kind is used to divide questions into categories, so that when iterating in the view
  # the correct mark-up is rendered.
  enum kind: { multiple_choice: 0,
               multiple_choice_with_other: 1,
               multiple_choice_with_effect_on_next: 2,
               yes_no_with_optional: 3,
               area: 4,
               distance: 5,
               short_length: 6,
               long_length: 7,
               quantity: 8,
               description: 9
  }.freeze

  AREA_QUESTION = { kind: :area, wording: "Estimated number of acres/hectacres?", options: ["acres", "hectares"], label: "Number of acres/hectacres"}
  DESCRIPTION_QUESTION = { kind: :description, wording: "Please write a short decription of the job", label: "Description"}

  QUESTIONS = { 'Fertilizer Spreading' => [{ kind: :multiple_choice, wording: "What type of fertilizer do you want spread?", label: "Type of fertilizer", options: ["granular", "liquid"]},
                                           AREA_QUESTION, DESCRIPTION_QUESTION],
                'Lime Spreading' => [{ kind: :multiple_choice, wording: "Do you need a loader?", options: ["yes", "no"], label: "Loader"},
                                      AREA_QUESTION, DESCRIPTION_QUESTION],
                'Spraying (specialised)' => [{ kind: :multiple_choice, wording: "What type of spraying do you require?", options: ["ATV spraying", "Avadex application", "Slug pelleting", "Weed wiping", "Other"]},
                                             AREA_QUESTION, DESCRIPTION_QUESTION],
                'Spraying (standard)' => [{ kind: :multiple_choice, wording: "What type of spraying do you require?", options: ["Arable spraying", "Grassland spraying"]},
                                          AREA_QUESTION, DESCRIPTION_QUESTION],
                'Cereals - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", options: ["Any method", "Combi-drill", "Conventional", "Direct"]},
                                         AREA_QUESTION, DESCRIPTION_QUESTION],
                'Grass Seed - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", options: ["Any method", "Broadcast", "Cross Drilling", "Harrow"]},
                                            AREA_QUESTION, DESCRIPTION_QUESTION],
                'Maize - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", options: ["Precision", "Under film"]},
                                       AREA_QUESTION, DESCRIPTION_QUESTION],
                'Oil Seed Rape - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", options: [] },
                                               AREA_QUESTION, DESCRIPTION_QUESTION],
                'Potatoes - Drilling' => [AREA_QUESTION, DESCRIPTION_QUESTION],
                'Sugar Beet - Drilling' => [AREA_QUESTION, DESCRIPTION_QUESTION],
                'Vegetables - Drilling' => [{ kind: :multiple_choice_with_other, wording: "What type of vegetables are you sowing?", options: [ "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Kale", "Leek", "Lettuce", "Onion", "Peas", "Rhubarb", "Turnip", "Other"]}]
                                            }


  def convert_and_store_area
    if details["unit"] == "acres"
      details["acres"] = details["value"].to_i
      details["hectares"] = (details["value"].to_i * 0.404686)
    elsif details["unit"] == "hectares"
      details["hectares"] = details["value"].to_i
      details["acres"] = (details["value"].to_i * 2.47105)
    end
    details.delete("unit")
    details.delete("value")
  end
end

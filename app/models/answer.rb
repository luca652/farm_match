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
                                          AREA_QUESTION, DESCRIPTION_QUESTION]
                                            }


  def convert_and_store_area
    if details["unit"] == "acres"
      details["acres"] = details["value"]
      details["hectares"] = (details["value"].to_i * 0.404686).to_s
    elsif details["unit"] == "hectares"
      details["hectares"] = details["value"]
      details["acres"] = (details["value"].to_i * 2.47105).to_s
    end
    details.delete("unit")
    details.delete("value")
  end
end

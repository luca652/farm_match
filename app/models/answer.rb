class Answer < ApplicationRecord
  belongs_to :service

  validates :label, presence: true

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
               quantity: 8
  }.freeze

  QUESTIONS = { 'Fertilizer Spreading' => [{ kind: :multiple_choice, wording: "What type of fertilizer do you want spread?", label: "Type of fertilizer", options: ["granular", "liquid"]},
                                           { kind: :area, wording: "Estimated number of acres/hectacres?", label: "Number of acres/hectacres", options: ["acres", "hectares"]}],
                'Lime Spreading' => [],
                'Spraying (specialised)' => [],
                'Spraying (standard)' => []
              }
end

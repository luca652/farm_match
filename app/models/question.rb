class Question < ApplicationRecord
  belongs_to :service
  store_accessor :answer, :unit, :value

  # validates :unit, presence: true, if: -> { kind.to_sym == :area }
  # validates :value, presence: true, numericality: true, if: -> { kind.to_sym == :area }

  # before_save :convert_and_store_area

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

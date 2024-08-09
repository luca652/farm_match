class Question < ApplicationRecord
  before_validation :normalize_answer, if: :answer_provided?

  belongs_to :service

  # store_accessor: method provided by ActiveRecord in Rails to work with serialized hash attributes,
  # typically stored in a JSON or JSONB column in the database. It allows you to treat keys within the serialized hash
  # as if they were regular attributes on the model.
  store_accessor :answer, :unit, :value, :other, :values

  # the validations are applied conditionally when the answers are provided by the user.
  # this is necessary because we create all instances of Question connected to a Service with an after_create action in the Service model.
  # This ensures that the question can be created with answer set to {} without failing the validations.
  validates :answer, presence: true, if: :answer_provided?
  validates_with JsonAnswerValidator, if: :answer_provided?

  # kind is used to divide questions into categories, so that when iterating in the view the correct mark-up is rendered.
  enum kind: { multiple_choice: 0,
               multiple_choice_with_check_boxes: 1,
               multiple_choice_with_other: 2,
               multiple_choice_with_effect_on_next: 3,
               multiple_choice_with_optional: 4,
               unit_and_value: 5,
               quantity: 6
  }.freeze


  private

  # Given that the answer attribute is set to JSON and defaults to an empty hash, this method ensures that
  # 1. when the answer is a string, it is saved in the hash as a hash { value: string } to maintain data consistency
  # 2. when the answer is an array, it is saved as a { values: [string, string...]}
  def normalize_answer
    if answer.is_a?(String)
      self.answer = { value: answer }
    elsif answer.is_a?(Array)
      # Remove empty strings and normalize
      normalized_array = answer.reject(&:blank?)
      self.answer = { values: normalized_array }
    end
  end

  def answer_provided?
    answer.present? && answer != {}
  end

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

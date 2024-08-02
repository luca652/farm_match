class Question < ApplicationRecord
  belongs_to :service
  # store_accessor: method provided by ActiveRecord in Rails to work with serialized hash attributes,
  # typically stored in a JSON or JSONB column in the database. It allows you to treat keys within the serialized hash
  # as if they were regular attributes on the model.
  store_accessor :answer, :unit, :value

  # the validations are applied conditionally when the answers are provided by the user.
  # this is necessary because we create all instances of Question connected to a Service with an after_create action in the Service model.
  # This ensures that the question can be created with answer set to {} without failing the validations.
  validates :answer, presence: true, if: :answer_provided?
  validates_with JsonAnswerValidator, if: :answer_provided?

  # kind is used to divide questions into categories, so that when iterating in the view the correct mark-up is rendered.
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

  # Given that the answer attribute is set to JSON and defaults to an empty hash, this method ensures that
  # when the answer is a string, it is saved in the hash as a hash { value: string } to maintain data consistency
  def answer=(input)
    if input.is_a?(Hash) && input.key?(:answer)
      selected_answer = input[:answer]
      other_answer = input[:other_answer].presence

      if selected_answer == 'other' && other_answer
        super(value: other_answer)
      else
        super(value: selected_answer)
      end
    elsif input.is_a?(String)
      super(value: input)
    else
      super(input)
    end
  end

  def answer_provided?
    answer.present? && answer != {}
  end

  def validate_answer_based_on_question_kind
    case kind.to_sym
    when :multiple_choice
      validate_multiple_choice
    when :area
      validate_area
    when :text
      validate_text
    # Add more cases for other question types
    end
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

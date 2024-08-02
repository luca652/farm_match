class JsonAnswerValidator < ActiveModel::Validator
  def validate(record)
    answer = record.answer
    kind = record.kind

    case kind
    when "multiple_choice"
      validate_multiple_choice(record, answer)
    when "area"
      validate_area(record, answer)
    # Add more cases for other types as needed
    else
      record.errors.add(:answer, 'has an invalid kind')
    end
  end

  private

  def validate_multiple_choice(record, answer)

    unless answer.is_a?(Hash)
      record.errors.add(:answer, "Answer must be a JSON object.")
      return
    end

    unless answer.key?('value')
      record.errors.add(:answer, "Answer must include a 'value' key.")
    end

    unless answer['value'].is_a?(String)
      record.errors.add(:answer, "'value' must be a number.")
    end
  end

  def validate_area(record, answer)
    unless answer.is_a?(Hash)
      record.errors.add(:answer, "Answer must be a JSON object.")
      return
    end

    unless answer.key?('value')
      record.errors.add(:answer, "Answer must include a 'value' key.")
    end

    unless answer["value"].is_a?(String) && answer["value"].match?(/\A\d+\z/)
      record.errors.add(:answer, "'value' must be a number.")
    end

    unless answer["value"].to_i > 0
      record.errors.add(:answer, "'value' cannot be negative")
    end

    unless answer.key?('unit')
      record.errors.add(:answer, "Answer must include a 'unit' key.")
    end

    unless answer['unit'].is_a?(String)
      record.errors.add(:answer, "'unit' must be a string.")
    end
  end
end

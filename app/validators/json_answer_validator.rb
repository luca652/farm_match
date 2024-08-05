class JsonAnswerValidator < ActiveModel::Validator
  def validate(record)
    answer = record.answer
    kind = record.kind

    case kind
    when "multiple_choice"
      validate_multiple_choice(record, answer)
    when "area"
      validate_area(record, answer)
    when "multiple_choice_with_other"
      p "fine for now!"
    # Add more cases for other types as needed
    else
      record.errors.add(:base, 'has an invalid kind')
    end
  end

  private

  def validate_multiple_choice(record, answer)
    unless answer.is_a?(Hash)
      record.errors.add(:base, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Developer: Answer must be a JSON object. Provided answer: #{answer.inspect}")
      return
      # returning here prevents the other checks from running and raising errors.
    end

    unless answer.key?('value') && answer['value'].is_a?(String) && answer['value'].present?
      record.errors.add(:base, "Answer must include a 'value' key.")
    end
  end


  def validate_area(record, answer)
    unless answer.is_a?(Hash)
      record.errors.add(:base, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Developer: Answer must be a JSON object. Provided answer: #{answer.inspect}")
      return
    end

    unless answer['unit'].is_a?(String) && answer['unit'].present?
      record.errors.add(:base, "you must select an option")
    end

    unless answer['value'].is_a?(String) && answer['value'].match?(/\A\d+\z/) && answer['value'].to_i > 0
      p "number validation failed!!!!"
      record.errors.add(:base, "you must enter a positive number as value")
      p "record errors: #{record.errors.inspect}"
      p "answer error: #{}"
    end
  end
end

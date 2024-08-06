class JsonAnswerValidator < ActiveModel::Validator
  def validate(record)
    answer = record.answer
    kind = record.kind

    case kind
    when "multiple_choice"
      validate_multiple_choice(record, answer)
    when "unit_and_value"
      validate_area(record, answer)
    when "multiple_choice_with_other"
      validate_multiple_choice_with_other(record, answer)
    # Add more cases for other types as needed
    else
      record.errors.add(:answer, 'has an invalid kind')
    end
  end

  private

  def validate_multiple_choice(record, answer)
    unless answer.is_a?(Hash)
      record.errors.add(:answer, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Answer must be a JSON object. Provided answer: #{answer.inspect}")
      return
      # returning here prevents the other checks from running and raising errors.
    end

    unless answer.key?('value') && answer['value'].is_a?(String) && answer['value'].present?
      record.errors.add(:answer, "You must select an option from the list.")
    end
  end

  def validate_multiple_choice_with_other(record, answer)
    unless answer.is_a?(Hash)
      record.errors.add(:answer, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Answer must be a JSON object. Provided answer: #{answer.inspect}")
      return
      # returning here prevents the other checks from running and raising errors.
    end

    unless answer.key?('value') && answer['value'].is_a?(String) && answer['value'].present?
      record.errors.add(:answer, "You must select an option from the list.")
    end

    if answer['value'] == 'Other'
      if answer['other'].blank?
        record.errors.add(:answer, "You must enter a value.")
      end
    end
  end


  def validate_area(record, answer)
    unless answer.is_a?(Hash)
      record.errors.add(:answer, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Answer must be a JSON object. Provided answer: #{answer.inspect}")
      return
    end

    unless answer['unit'].is_a?(String) && answer['unit'].present?
      record.errors.add(:answer, "You must select an option.")
    end

    unless answer['value'].is_a?(String) && answer['value'].match?(/\A\d+\z/) && answer['value'].to_i > 0
      p "number validation failed!!!!"
      record.errors.add(:answer, "You must enter a positive number.")
      p "record errors: #{record.errors.inspect}"
      p "answer error: #{}"
    end
  end
end

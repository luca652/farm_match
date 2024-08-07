class JsonAnswerValidator < ActiveModel::Validator
  def validate(record)
    answer = record.answer
    kind = record.kind

    case kind
    when "multiple_choice"
      validate_multiple_choice(record, answer)
    when "multiple_choice_with_other"
      validate_multiple_choice_with_other(record, answer)
    when "multiple_choice_with_effect_on_next"
      validate_multiple_choice(record, answer)
    when "multiple_choice_with_optional"
      validate_multiple_choice(record, answer)
    when "unit_and_value"
      validate_unit_and_value(record, answer)
    when "quantity"
      validate_quantity(record, answer)
    when "multiple_choice_with_check_boxes"
      validate_multiple_choice_with_check_boxes(record, answer)
      # Add more cases for other types as needed
    else
      record.errors.add(:answer, 'has an invalid kind')
    end
  end

  private

  def validate_multiple_choice(record, answer)
    # this prevents optional questions with no answer from being validated
    return if record.optional? && answer[:value].blank?

    unless answer.is_a?(Hash)
      record.errors.add(:answer, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Answer must be a JSON object. Provided answer: #{answer.inspect}")
      p "Failed validate_multiple_choice"
      return
    end

    unless answer.key?('value') && answer['value'].is_a?(String) && answer['value'].present?
      record.errors.add(:answer, "You must select an option from the list.")
    end
  end

  def validate_multiple_choice_with_other(record, answer)

    unless answer.is_a?(Hash)
      record.errors.add(:answer, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Answer must be a JSON object. Provided answer: #{answer.inspect}")
       p "Failed validate_multiple_choice_with_other"
      return
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

  def validate_multiple_choice_with_check_boxes(record, answer)

    unless answer.is_a?(Hash)
      record.errors.add(:answer, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Answer must be a JSON object. Provided answer: #{answer.inspect}")
       p "Failed validate_multiple_choice_with_other"
      return
    end

    unless answer.key?('values') && answer['values'].is_a?(Array) && answer['values'].present?
      record.errors.add(:answer, "You must select at least an option from the list.")
    end
  end

  def validate_unit_and_value(record, answer)
     # this prevents optional questions with no answer from being validated
    return if record.optional? && answer[:value].blank? && answer[:unit].blank?

    unless answer.is_a?(Hash)
      record.errors.add(:answer, "There was a problem saving your answer, please try again later.")
      Rails.logger.error("Answer must be a JSON object. Provided answer: #{answer.inspect}")
      return
    end

    unless answer['unit'].is_a?(String) && answer['unit'].present?
      record.errors.add(:answer, "You must select an option.")
    end

    must_enter_positive_number(record, answer)
  end

  def validate_quantity(record, answer)

    return if record.optional? && answer.blank?

    must_enter_positive_number(record, answer)
  end

  def must_enter_positive_number(record, answer)
    unless answer['value'].is_a?(String) && answer['value'].match?(/\A\d+\z/) && answer['value'].to_i > 0
      record.errors.add(:answer, "You must enter a positive number.")
    end
  end
end

module CustomInputs
  class AreaInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      @builder.fields_for :answer, OpenStruct.new(object.answer) do |ff|
        template.content_tag(:fieldset, class: 'area-input form-field') do
          template.content_tag(:legend, @builder.object.wording) +
          ff.label(:unit, "Unit") +
          ff.select(:unit, object.options, { prompt: "- Select -" }, class: 'area-unit form-field') +
          ff.label(:value, "Value") +
          ff.number_field(:value, value: object.answer['value'], placeholder: "e.g. 25", min: "1", class: 'area-value form-field')
        end
      end
    end
  end
end

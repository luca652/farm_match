module CustomInputs
  class AreaInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      @builder.fields_for :answer, OpenStruct.new(object.answer) do |ff|
        template.content_tag(:div, class: 'area-input') do
          ff.select(:unit, object.options, { selected: object.answer['unit'] }, class: 'area-unit') +
          ff.number_field(:value, value: object.answer['value'], class: 'area-value')
        end
      end
    end
  end
end

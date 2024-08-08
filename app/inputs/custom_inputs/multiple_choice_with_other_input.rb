module CustomInputs
  class MultipleChoiceWithOtherInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      @builder.fields_for :answer, object.answer || {} do |ff|
        ff.collection_radio_buttons(:value, object.options, :to_s, :to_s) do |b|
          b.radio_button(
            checked: object.answer["value"] == b.value,
            data: {
              action: "change->dynamic-form#toggleOtherField"
            }
          ) + b.label { b.text }
        end +
        ff.input(:other,
          label: false,
          wrapper_html: {
            class: object.answer["value"] == "Other" ? "" : "hidden",
            data: { dynamic_form_target: "otherField" }
          },
          input_html: {
            value: object.answer["other"],
            class: 'form-field',
            placeholder: "Please fill in with another option"
          }
        )
      end
    end
  end
end

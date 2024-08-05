module CustomInputs
  class MultipleChoiceWithOtherInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      @builder.fields_for :answer, object.answer || {} do |ff|
        template.content_tag(:fieldset, class: 'multiple-with-other-input form-field', data: { controller: "question"}) do
          template.content_tag(:legend, object.wording) +
          ff.input(:value,
            collection: object.options,
            prompt: "- Select -",
            selected: object.answer["value"] || nil,
            input_html: {
              class: 'area-unit form-field',
                data: { action: "change->question#toggleOtherField",
                        question_target: "valueField"
              }
            }
          ) +
          ff.input(:other,
            wrapper_html: {
              class: "hidden",
              data: { question_target: "otherInput", action: "input->question#updateAnswer" }
            },
            input_html: {
              value: object.answer["other"] || nil,
              class: 'form-field',
              placeholder: "Please fill in with another option"
            }
          )
        end
      end
    end
  end
end

module CustomInputs
  class MultipleChoiceWithEffectOnNextInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      @builder.fields_for :answer, object.answer || {} do |ff|
        ff.input(:value,
          collection: object.options,
          prompt: "- Select -",
          label: false,
          selected: object.answer["value"] || nil,
          input_html: { class: 'value form-field',
                        data: { action: "change->dynamic-form#setOptionsForQuestion",
                        dynamic_form_question_wording: object.wording }}
        )
      end
    end
  end
end

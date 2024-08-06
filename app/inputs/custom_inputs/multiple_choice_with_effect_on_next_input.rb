module CustomInputs
  class MultipleChoiceWithEffectOnNextInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      @builder.fields_for :answer, object.answer || {} do |ff|
        ff.input(:value,
          collection: object.options,
          prompt: "- Select -",
          label: false,
          selected: object.answer["unit"] || nil,
          input_html: { class: 'unit form-field',
                        data: { action: "change->options#setOptionsForQuestion",
                        options_question_wording: object.wording}}
        )
      end
    end
  end
end

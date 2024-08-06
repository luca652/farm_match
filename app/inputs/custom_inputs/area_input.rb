module CustomInputs
  class AreaInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      @builder.fields_for :answer, object.answer || {} do |ff|
        ff.input(:unit,
          collection: object.options,
          prompt: "- Select a unit -",
          label: false,
          selected: object.answer["unit"] || nil,
          input_html: { class: 'area-unit form-field' }
        ) +
        ff.input(:value,
          as: :numeric,
          label: false,
          input_html: {
            value: object.answer["value"] || nil,
            min: 1,
            class: 'area-value form-field',
            placeholder: "e.g. 10",
            data: { action: "change->validation#isPositiveInteger" },
            'aria-describedby': "value-description"
          }
        )
      end
    end
  end
end

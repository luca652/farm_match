module QuestionnaireGenerator
  extend ActiveSupport::Concern

  AREA_QUESTION = { kind: :unit_and_value, wording: "Estimated number of acres/hectacres?", options: ["acres", "hectares"], answer_title: "Area"}
  LENGTH_OF_MOWING_QUESTION = { kind: :unit_and_value, wording: "Estimated length of mowing required? (Pick one measurement)", answer_title: "Estimated length", collection: ["Feet", "Meters", "Miles", "Kilometers"]}

  QUESTIONS = { 'Fertilizer Spreading' => [{ kind: :multiple_choice, wording: "What type of fertilizer do you want spread?", answer_title: "Type of fertilizer", options: ["granular", "liquid"]},
                                           AREA_QUESTION],
                'Lime Spreading' => [{ kind: :multiple_choice, wording: "Do you need a loader?", options: ["yes", "no"], answer_title: "Loader"},
                                      AREA_QUESTION],
                'Spraying (specialised)' => [{ kind: :multiple_choice, wording: "What type of spraying do you require?", answer_title: "Type of spraying", options: ["ATV spraying", "Avadex application", "Slug pelleting", "Weed wiping", "Other"]},
                                             AREA_QUESTION],
                'Spraying (standard)' => [{ kind: :multiple_choice, wording: "What type of spraying do you require?", answer_title: "Type of spraying", options: ["Arable spraying", "Grassland spraying"]},
                                          AREA_QUESTION],
                'Cereals - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: ["Any method", "Combi-drill", "Conventional", "Direct"]},
                                         AREA_QUESTION],
                'Grass Seed - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: ["Any method", "Broadcast", "Cross Drilling", "Harrow"]},
                                            AREA_QUESTION],
                'Maize - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: ["Precision", "Under film"]},
                                       AREA_QUESTION],
                'Oil Seed Rape - Drilling' => [{ kind: :multiple_choice, wording: "Preferred method of drilling?", answer_title: "Drilling method", options: [] },
                                               AREA_QUESTION],
                'Potatoes - Drilling' => [AREA_QUESTION],
                'Sugar Beet - Drilling' => [AREA_QUESTION],
                'Vegetables - Drilling' => [{ kind: :multiple_choice_with_other, wording: "What type of vegetables are you sowing?", answer_title: "Type of vegetable", options: [ "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Kale", "Leek", "Lettuce", "Onion", "Peas", "Rhubarb", "Turnip", "Other"]},
                                            AREA_QUESTION],
                # SERVICE: 'Fencing & Hedging'
                'Fence Erection' => [{ kind: :multiple_choice, wording: "What type of fence do you require?", answer_title: "Type of fence", options: ["Post and four barb", "Post and three rails", "Post, stock, net and two barb"]},
                                     LENGTH_OF_MOWING_QUESTION],
                'Hedge Laying' => [LENGTH_OF_MOWING_QUESTION],
                'Verge Bank Mowing' => [LENGTH_OF_MOWING_QUESTION],
                # SERVICE: 'Grassland Harvesting'
                'Baling - FULL SERVICE (Mow, Ted/Rake, Bale, Wrap, Transport etc)' => [AREA_QUESTION, { kind: :multiple_choice_with_effect_on_next, wording: "What type of bale do you want?", answer_title: "Type of bale", options: ["Round", "Square"]},
                                                                                       { kind: :multiple_choice, wording: "What size of bale?", options: [] }
                                                                                      ]

                }

  FOLLOW_UP_OPTIONS =  { "What type of bale do you want?" => {"Round" => ["Round 120cm", "Round 150cm"], "Square" => ["Square - 120x130cm", "Square - 120x70cm", "Square - 120x90cm", "Square - 80x90cm", "Square - Small Conventional"]}}

  def generate_questions_for_service(service)
    QUESTIONS[service.name].map do |question_attrs|
      service.questions.create!(question_attrs)
    end
  end
end

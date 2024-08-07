module QuestionnaireGenerator
  extend ActiveSupport::Concern

  AREA_QUESTION = {
    kind: :unit_and_value,
    wording: "Estimated number of acres/hectacres?",
    options: ["acres", "hectares"],
    answer_title: "Area"
  }

  LENGTH_OF_MOWING_QUESTION = {
    kind: :unit_and_value,
    wording: "Estimated length of mowing required? (Pick one measurement)",
    answer_title: "Estimated length",
    options: ["Feet", "Meters", "Miles", "Kilometers"]
  }

  BALE_TYPE_QUESTION = {
    kind: :multiple_choice_with_effect_on_next,
    wording: "What type of bale do you want?",
    answer_title: "Type of bale",
    options: ["Round", "Square"]
  }

  BALE_SIZE_QUESTION = {
    kind: :multiple_choice,
    wording: "What size of bale?",
    options: []
  }

  BALE_BOUND_QUESTION = {
    kind: :multiple_choice,
    wording: "How do you want the bale bound?",
    options: ["Net wrap", "Twine"]
  }

  BALE_CHOPPED_QUESTION = {
    kind: :multiple_choice,
    wording: "Do you want the bale chopped?",
    options: ["Yes", "No"]
  }

  BALE_NUMBER_QUESTION = {
    kind: :quantity,
    wording: "Estimated number of bales?"
  }

  DISTANCE_FROM_FURTHEST_FIELD_QUESTION = {
    kind: :unit_and_value,
    wording: "Estimated distance from furthest field to yard?",
    options: ["Miles", "Kilometers"]
  }

  PIT_COVERED_QUESTION = {
    kind: :multiple_choice,
    wording: "Do you need the pit to be covered?",
    options: ["Yes", "No"]
  }

  SILAGE_ADDITIVES_QUESTION = {
    kind: :multiple_choice,
    wording: "Do you want additives added to the silage?",
    options: ["Yes", "No"]
  }

  CROP_CONDITIONED_QUESTION = {
    kind: :multiple_choice,
    wording: "Do you need the crop conditioned?",
    options: ["Yes", "No"]
  }

  QUESTIONS = {
    # SUBCATEGORY: 'Application (Spraying & Spreading)'
    'Fertilizer Spreading' => [
      {
        kind: :multiple_choice,
        wording: "What type of fertilizer do you want spread?",
        answer_title: "Type of fertilizer",
        options: ["granular", "liquid"]
      },
      AREA_QUESTION
    ],
    'Lime Spreading' => [
      {
        kind: :multiple_choice,
        wording: "Do you need a loader?",
        options: ["yes", "no"],
        answer_title: "Loader"
      },
      AREA_QUESTION
    ],
    'Spraying (specialised)' => [
      {
        kind: :multiple_choice,
        wording: "What type of spraying do you require?",
        answer_title: "Type of spraying",
        options: ["ATV spraying", "Avadex application", "Slug pelleting", "Weed wiping", "Other"]
      },
      AREA_QUESTION
    ],
    'Spraying (standard)' => [
      { kind: :multiple_choice,
        wording: "What type of spraying do you require?",
        answer_title: "Type of spraying",
        options: ["Arable spraying", "Grassland spraying"]
      },
      AREA_QUESTION
    ],
    # SUBCATEGORY: 'Drilling & Sowing'
    'Cereals - Drilling' => [
      {
        kind: :multiple_choice,
        wording: "Preferred method of drilling?",
        answer_title: "Drilling method",
        options: ["Any method", "Combi-drill", "Conventional", "Direct"]
      },
      AREA_QUESTION
    ],
    'Grass Seed - Drilling' => [
      {
        kind: :multiple_choice,
        wording: "Preferred method of drilling?",
        answer_title: "Drilling method",
        options: ["Any method", "Broadcast", "Cross Drilling", "Harrow"]
      },
      AREA_QUESTION
    ],
    'Maize - Drilling' => [
      {
        kind: :multiple_choice,
        wording: "Preferred method of drilling?",
        answer_title: "Drilling method",
        options: ["Precision", "Under film"]
      },
      AREA_QUESTION
    ],
    'Oil Seed Rape - Drilling' => [
      {
        kind: :multiple_choice,
        wording: "Preferred method of drilling?",
        answer_title: "Drilling method",
        options: []
      },
      AREA_QUESTION
    ],
    'Potatoes - Drilling' => [
      AREA_QUESTION
    ],
    'Sugar Beet - Drilling' => [
      AREA_QUESTION
    ],
    'Vegetables - Drilling' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What type of vegetables are you sowing?",
        answer_title: "Type of vegetable",
        options: [ "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Kale", "Leek", "Lettuce", "Onion", "Peas", "Rhubarb", "Turnip", "Other"]
      },
      AREA_QUESTION
    ],
    # SUBCATEGORY: 'Fencing & Hedging'
    'Fence Erection' => [
      {
        kind: :multiple_choice,
        wording: "What type of fence do you require?",
        answer_title: "Type of fence",
        options: ["Post and four barb", "Post and three rails", "Post, stock, net and two barb"]
      },
      LENGTH_OF_MOWING_QUESTION
    ],
    'Hedge Laying' => [
      LENGTH_OF_MOWING_QUESTION
    ],
    'Verge Bank Mowing' => [
      LENGTH_OF_MOWING_QUESTION
    ],
    # SUBCATEGORY: 'Grassland Harvesting'
    'Baling - FULL SERVICE (Mow, Ted/Rake, Bale, Wrap, Transport etc)' => [
      AREA_QUESTION,
      BALE_TYPE_QUESTION,
      BALE_SIZE_QUESTION,
      BALE_BOUND_QUESTION,
      BALE_CHOPPED_QUESTION,
      {
        kind: :multiple_choice,
        wording: "Do you want the bales wrapped?",
        options: ["Yes", "No"]
      },
      {
        kind: :multiple_choice,
        wording: "Do you need the bales drawn away?",
        options: ["Yes", "No"]
      },
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION
    ],
    'Mowing' => [
      AREA_QUESTION,
      CROP_CONDITIONED_QUESTION
    ],
    'Tedding' => [
      AREA_QUESTION
    ],
    'Raking' => [
      AREA_QUESTION
    ],
    'Baling' => [
      AREA_QUESTION,
      BALE_TYPE_QUESTION,
      BALE_SIZE_QUESTION,
      BALE_BOUND_QUESTION,
      BALE_CHOPPED_QUESTION
    ],
    'Wrapping' => [
      BALE_NUMBER_QUESTION,
      BALE_TYPE_QUESTION,
      BALE_SIZE_QUESTION,
      {
        kind: :multiple_choice,
        wording: "How many layers of film per bale?",
        options: ["4 layers", "6 layers"]
      },
      {
        kind: :multiple_choice,
        wording: "Do you want to supply the film?",
        options: ["Yes", "No"]
      }
    ],
    'Bale Chasing/Haulage' => [
      BALE_NUMBER_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION
    ],
    'Topping' => [
      AREA_QUESTION
    ],
    'Silage Harvesting - Complete Service (wholecrop, Harvesting, trailers, pit building, clamping)' => [
      CROP_CONDITIONED_QUESTION,
      AREA_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION,
      PIT_COVERED_QUESTION,
      SILAGE_ADDITIVES_QUESTION,
    ],
    'Silage Harvesting - Harvesting, trailers, Pit building, clamping' => [
      AREA_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION,
      PIT_COVERED_QUESTION,
      SILAGE_ADDITIVES_QUESTION
    ],
    'Silage Harvesting - Harvesting only' => [
      AREA_QUESTION
    ],
    'Forage Wagon - Complete Service (Wholecrop, Pit Building, Clamping)' => [
      CROP_CONDITIONED_QUESTION,
      AREA_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION,
      PIT_COVERED_QUESTION,
      SILAGE_ADDITIVES_QUESTION
    ],
    'Forage Wagon - Harvesting, Pit Building & Clamping' => [
      AREA_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION,
      PIT_COVERED_QUESTION,
      SILAGE_ADDITIVES_QUESTION
    ],
    'Forage Wagon - Harvesting only' => [
      AREA_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION
    ],
    # SUBCATEGORY: 'Crop Harvesting'
    'Beet Harvesting' => [
      {
        kind: :multiple_choice,
        wording: "What type of beet is it?",
        options: ["Fodder beet", "Sugar beet"]
      },
      {
        kind: :multiple_choice_with_optional,
        wording: "Do you require transportation/carting?",
        options: ["Yes", "No"]
      },
      {
        kind: :unit_and_value,
        wording: "What is the estimated distance for haulage?",
        options: ["Miles", "Kilometers"],
        optional: true
      },
      AREA_QUESTION
    ]
  }

  FOLLOW_UP_OPTIONS =  { "What type of bale do you want?" => {"Round" => ["Round 120cm", "Round 150cm"], "Square" => ["Square - 120x130cm", "Square - 120x70cm", "Square - 120x90cm", "Square - 80x90cm", "Square - Small Conventional"]}}

  def generate_questions_for_service(service)
    QUESTIONS[service.name].map do |question_attrs|
      service.questions.create!(question_attrs)
    end
  end
end

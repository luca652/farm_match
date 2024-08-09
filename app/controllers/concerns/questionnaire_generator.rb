module QuestionnaireGenerator
  extend ActiveSupport::Concern

  AREA_QUESTION = {
    kind: :unit_and_value,
    wording: "Estimated number of acres/hectacres?",
    options: ["Acres", "Hectares"],
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

  TRANSPORTATION_CARTING_QUESTION = {
    kind: :multiple_choice_with_optional,
    wording: "Do you require transportation/carting?",
    options: ["Yes", "No"]
  }

  DISTANCE_FOR_HAULAGE_QUESTION = {
    kind: :unit_and_value,
    wording: "What is the estimated distance for haulage?",
    options: ["Miles", "Kilometers"],
    optional: true
  }

  AMOUNT_OF_HEDGES_QUESTION = {
    kind: :unit_and_value,
    wording: "Estimated amount of hedges to be cut",
    options: ["Meters", "Feet"],
  }

  REQUIRE_A_DRIVER_QUESTION = {
      kind: :multiple_choice,
      wording: "Do you require a driver?",
      options: ["Yes", "No"]
  }

  NUMBER_OF_HOURS_QUESTION = {
    kind: :quantity,
    wording: "Estimated number of hours required?"
  }

  ESTIMATED_AMOUNT_TONNES_KILOS_QUESTION = {
    kind: :unit_and_value,
    wording: "Estimated amount?",
    options: ["Tonnes", "Kilos"]
  }

  NEED_A_LOADER_QUESTION = {
    kind: :multiple_choice,
    wording: "Do you need a loader?",
    options: ["Yes", "No"],
    answer_title: "Loader"
  }

  TYPE_OF_MANURE_QUESTION = {
    kind: :multiple_choice,
    wording: "What type of manure?",
    options: ["Chicken litter", "Farmyard manure", "Wood chip"]
  }

  SCAFFOLDING_QUESTION = {
    kind: :multiple_choice,
    wording: "Is any scaffolding required?",
    options: ["Yes", "No"]
  }

  DUMPER_QUESTION = {
    kind: :multiple_choice,
    wording: "Is a dumper required?",
    options: ["Yes", "No"]
  }

  NUMBER_OF_ANIMALS_QUESTION = {
    kind: :quantity,
    wording: "Estimated number of animals?"
  }

  HOW_MANY_SHEEP_QUESTION = {
    kind: :quantity,
    wording: "How many sheep?"
  }

  HOW_MANY_RAMS_QUESTION = {
    kind: :quantity,
    wording: "How many rams?"
  }

  WORK_FROM_A_HEIGHT_QUESTION = {
    kind: :multiple_choice,
    wording: "Will any of the work be done from a height?",
    options: ["Yes", "No"]
  }

  MAXIMUM_HEIGHT_QUESTION = {
    kind: :unit_and_value,
    wording: "What is the maximum height?",
    options: ["Feet", "Meters"]
  }

  OWN_EQUIPMENT_QUESTION = {
    kind: :multiple_choice,
    wording: "Do you have your own equipment?",
    options: ["Yes", "No"]
  }

  QUESTIONS = {
    # SUBCATEGORY: 'Application (Spraying & Spreading)'
    'Fertilizer Spreading' => [
      {
        kind: :multiple_choice,
        wording: "What type of fertilizer do you want spread?",
        answer_title: "Type of fertilizer",
        options: ["Granular", "Liquid"]
      },
      AREA_QUESTION
    ],
    'Lime Spreading' => [
      NEED_A_LOADER_QUESTION,
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
      TRANSPORTATION_CARTING_QUESTION,
      DISTANCE_FOR_HAULAGE_QUESTION,
      AREA_QUESTION
    ],
    'Cereal Harvesting' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What type of crop is it?",
        options: ["Barley", "Flax", "Millet", "Oats", "Rye", "Soyabean", "Wheat", "Other"]
      },
      {
        kind: :multiple_choice,
        wording: "Do you require straw chopping?",
        options: ["Yes", "No"]
      },
      TRANSPORTATION_CARTING_QUESTION,
      DISTANCE_FOR_HAULAGE_QUESTION,
      AREA_QUESTION
    ],
    'Potato Harvesting' => [
      TRANSPORTATION_CARTING_QUESTION,
      DISTANCE_FOR_HAULAGE_QUESTION,
      AREA_QUESTION
    ],
    'Vegetable Harvesting' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What type of crop do you need harvested?",
        options: [ "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Kale", "Leek", "Lettuce", "Onion", "Peas", "Rhubarb", "Turnip", "Other"]
      },
      TRANSPORTATION_CARTING_QUESTION,
      DISTANCE_FOR_HAULAGE_QUESTION,
      AREA_QUESTION
    ],
    # SERVICE: 'Hedge Cutting'
    'Hedge cutting - Saw' => [
      {
        kind: :unit_and_value,
        wording: "Estimated amount of hedges to be cut",
        options: ["Meters", "Feet"],
      }
    ],
    'Hedge cutting - Flail' => [
      AMOUNT_OF_HEDGES_QUESTION
    ],
    # SERVICE: 'Machine & Tractor Hire'
    'Forklift Hire' => [
      REQUIRE_A_DRIVER_QUESTION,
      NUMBER_OF_HOURS_QUESTION
    ],
    'Loader Hire' => [
      REQUIRE_A_DRIVER_QUESTION,
      NUMBER_OF_HOURS_QUESTION
    ],
    'Tractor Hire' => [
      REQUIRE_A_DRIVER_QUESTION,
      {
        kind: :multiple_choice,
        wording: "Do you require a trailer?",
        options: ["Yes", "No"]
      },
      {
        kind: :multiple_choice,
        wording: "What sized tractor do you require?",
        options: ["<100", "100-150", "150-220", "220-300", "300+"]
      },
      NUMBER_OF_HOURS_QUESTION
    ],
    'Teleporter Hire' => [
      REQUIRE_A_DRIVER_QUESTION,
      NUMBER_OF_HOURS_QUESTION
    ],
    # SERVICE: 'Maize Harvesting'
    'Maize Harvesting - Complete Service (wholecrop, Harvesting, trailers, pit building, clamping)' => [
      CROP_CONDITIONED_QUESTION,
      AREA_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION,
      PIT_COVERED_QUESTION,
      SILAGE_ADDITIVES_QUESTION
    ],
    'Maize Harvesting - Harvesting, trailers, Pit building, clamping' => [
      AREA_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION,
      PIT_COVERED_QUESTION,
      SILAGE_ADDITIVES_QUESTION
    ],
    'Maize Harvesting only' => [
      AREA_QUESTION
    ],
    # SERVICE: 'Mobile feeding'
    'Milling/Mixing' => [
      ESTIMATED_AMOUNT_TONNES_KILOS_QUESTION
    ],
    'Grain Crimping' => [
      ESTIMATED_AMOUNT_TONNES_KILOS_QUESTION
    ],
    # SERVICE: 'Muck & Slurry'
    'Muck Spreading' => [
      TYPE_OF_MANURE_QUESTION,
      NEED_A_LOADER_QUESTION,
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION
    ],
    'Muck Haulage' => [
      TYPE_OF_MANURE_QUESTION,
      NEED_A_LOADER_QUESTION,
      DISTANCE_FOR_HAULAGE_QUESTION
    ],
    'Slurry Spreading' => [
      {
        kind: :multiple_choice,
        wording: "What type of slurry do you need spread?",
        options: ["Cattle", "Pig", "Sheep"]
      },
      {
        kind: :multiple_choice,
        wording: "Do you need an agitator?",
        options: ["Yes", "No"]
      },
      DISTANCE_FROM_FURTHEST_FIELD_QUESTION,
      {
        kind: :multiple_choice,
        wording: "What type of spreading do you want?",
        options: ["Injection", "Dribble bar"]
      }
    ],
    # SERVICE: 'Painting & Powerwashing'
    'Painting' => [
      {
        kind: :multiple_choice,
        wording: "Will you supply your own paint?",
        options: ["Yes", "No"]
      },
      SCAFFOLDING_QUESTION
    ],
    'Powerwashing' => [
      SCAFFOLDING_QUESTION
    ],
    # SERVICE: 'Soil Preparation'
    'Bed tilling' => [
      AREA_QUESTION
    ],
    'Harrowing' => [
      {
        kind: :multiple_choice,
        wording: "What type of harrowing do you need?",
        options: ["Chain harrowing", "Disk harrowing", "Power Harrowing - shallow", "Power harrowing - deep", "Spring - tine harrowing"]
      },
      AREA_QUESTION
    ],
    'Land levelling' => [
      AREA_QUESTION
    ],
    'One pass tillage train' => [
      AREA_QUESTION
    ],
    'Ploughing' => [
      {
        kind: :multiple_choice_with_optional,
        wording: "What type of ploughing do you want?",
        options: ["Deep ploughing", "Mole Ploughing", "Ploughing - deep land", "Ploughing - light land"]
      },
      {
        kind: :multiple_choice,
        wording: "Do you want a furrow press following the plough?",
        options: ["Yes", "No"],
        optional: true
      },
      AREA_QUESTION
    ],
    'Pressing/Cultipress' => [
      AREA_QUESTION
    ],
    'Rolling' => [
      {
        kind: :multiple_choice,
        wording: "What type of roller do you want?",
        options: ["Flat roller", "Ring roller"]
      },
      AREA_QUESTION
    ],
    'Rotavating' => [
      AREA_QUESTION
    ],
    'Stubble Raking' => [
      AREA_QUESTION
    ],
    # SERVICE: 'Tree Cutting & Forestry'
    'Chainsaw & Operator' => [
      {
        kind: :unit_and_value,
        wording: "Estimated height of tallest tree?",
        options: ["Feet", "Meters"]
      },
      {
        kind: :quantity,
        wording: "Estimated number of trees?",
      }
    ],
    'Timber Harvesting' => [
      {
        kind: :multiple_choice,
        wording: "What type of timber?",
        options: ["Hardwood", "Softwood"]
      },
      {
        kind: :multiple_choice,
        wording: "Do you require a Skidder?",
        options: ["Yes", "No"]
      },
      {
        kind: :multiple_choice,
        wording: "Do You require a forwarder?",
        options: ["Yes", "No"]
      },
      AREA_QUESTION
    ],
    # SERVICE: 'Plant Hire & Earthworks'
    'Plant Hire (Self Drive)' => [
      {
        kind: :multiple_choice_with_check_boxes,
        wording: "Pick the type of machine(s) that are required",
        options: ["Track machine", "Wheeled Digger", "Bulldozer", "Dumper"]
      },
      {
        kind: :unit_and_value,
        wording: "Estimated length of time required?",
        options: ["Hours", "Days"]
      }
    ],
    'Escavation & Sitework' => [
      {
        kind: :multiple_choice,
        wording: "What type of machine is required?",
        options: ["Track machine", "Wheeled Digger", "Bulldozer"]
      },
      {
        kind: :multiple_choice,
        wording: "Do you require foundations dug?",
        options: ["Yes", "No"]
      },
      {
        kind: :multiple_choice,
        wording: "Will a rock-breaker be required?",
        options: ["Yes", "No"]
      },
      DUMPER_QUESTION
    ],
    'Land Clearing' => [
      {
        kind: :multiple_choice,
        wording: "Is tree stump removal required?",
        options: ["Yes", "No"]
      },
      {
        kind: :multiple_choice,
        wording: "Are there any large rocks/boulders to remove?",
        options: ["Yes", "No"]
      },
      DUMPER_QUESTION,
      AREA_QUESTION
    ],
    'Land Drainage' => [
      DUMPER_QUESTION,
      AREA_QUESTION
    ],
    'Tree Stump Removal' => [
      AREA_QUESTION
    ],
    'Ditch removal' => [
      {
        kind: :multiple_choice_with_optional,
        wording: "Do you want the ditch buried or removed?",
        options: ["Yes", "No"]
      },
      {
        kind: :unit_and_value,
        wording: "Do you want the ditch buried or removed?",
        options: ["Miles", "Kilometers"],
        optional: true
      },
      {
        kind: :unit_and_value,
        wording: "Estimated length of ditch?",
        options: ["Feet", "Meters"]
      }
    ],
    'Roadways' => [
      {
        kind: :unit_and_value,
        wording: "Estimated length of road?",
        options: ["Feet", "Meters"]
      }
    ],
    'Land Levelling' => [
      AREA_QUESTION
    ],
    'Stone Removal' => [
      AREA_QUESTION
    ],
    # SERVICE: 'Animal Care'
    'Castration' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Pigs", "Other"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    'Crutching (Dagging)' => [
      HOW_MANY_SHEEP_QUESTION,
      HOW_MANY_RAMS_QUESTION
    ],
    'De-horning' => [
      {
        kind: :multiple_choice,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Goat"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    'Dipping' => [
      HOW_MANY_SHEEP_QUESTION,
      HOW_MANY_RAMS_QUESTION
    ],
    'Docking (tail removal)' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Pigs", "Other"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    'Dosing' => [
      {
        kind: :multiple_choice,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Pigs"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    'Feeding' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Poultry", "Pigs", "Other"]
      },
      NUMBER_OF_ANIMALS_QUESTION,
      {
        kind: :multiple_choice_with_other,
        wording: "What type of feeding?",
        options: ["Diet Feeder", "Automated Feeding System", "Front Loader", "Manual Feeding", "Other"]
      },
      {
        kind: :unit_and_value,
        wording: "For how long do you require the animals to be feed?",
        options: ["Weeks", "Days"]
      }
    ],
    'Foot Trimming' => [
      {
        kind: :multiple_choice,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Goat"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    'Injection' => [
      {
        kind: :multiple_choice,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Pigs"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    'Lambing/Calfing/Animal Birthing' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Pigs", "Other"]
      },
      NUMBER_OF_ANIMALS_QUESTION,
      {
        kind: :unit_and_value,
        wording: "Estimated length period that assistance is required?",
        options: ["Weeks", "Days"]
      }
    ],
    'Shearing' => [
      HOW_MANY_SHEEP_QUESTION,
      HOW_MANY_RAMS_QUESTION,
      {
        kind: :multiple_choice,
        wording: "Are any wool packs required?",
        options: ["Yes", "No"]
      }
    ],
    'Shifting/Loading Livestock' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Poultry", "Pigs", "Other"]
      },
      NUMBER_OF_ANIMALS_QUESTION,
    ],
    'Tagging' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Goats", "Pigs", "Other"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    'Testing' => [
      {
        kind: :multiple_choice,
        wording: "What kind of animal?",
        options: ["Cattle", "Sheep", "Horses", "Pigs"]
      },
      NUMBER_OF_ANIMALS_QUESTION
    ],
    # SERVICE: 'Milking'
    'Milking' => [
      {
        kind: :multiple_choice_with,
        wording: "What kind of animal?",
        options: ["Cow", "Sheep", "Goat"]
      },
      NUMBER_OF_ANIMALS_QUESTION,
      {
        kind: :unit_and_value,
        wording: "Estimated period of time that milking reflief is required?",
        options: ["Weeks", "Days"]
      }
    ],
    # SERVICE: 'General Yard Duties'
    'Cleaning/Power Washing' => [
      OWN_EQUIPMENT_QUESTION,
      {
        kind: :multiple_choice,
        wording: "What needs to be cleaned?",
        options: ["Buildings & structures", "Machinery", "Both"]
      },
      WORK_FROM_A_HEIGHT_QUESTION,
      MAXIMUM_HEIGHT_QUESTION
    ],
    'Construction' => [
      OWN_EQUIPMENT_QUESTION,
      WORK_FROM_A_HEIGHT_QUESTION,
      MAXIMUM_HEIGHT_QUESTION
    ],
    'Machinery Maintenance' => [
      OWN_EQUIPMENT_QUESTION,
      {
        kind: :multiple_choice,
        wording: "What type of machinery?",
        options: ["Combine Harvester", "Forage harvester", "General Farm implements", "Tractors"]
      }
    ],
    # 'Mucking out sheds' => []
    'Painting' => [
      OWN_EQUIPMENT_QUESTION,
      {
        kind: :multiple_choice,
        wording: "What needs to be painted?",
        options: ["Buildings & structures", "Machinery", "Both"]
      },
      WORK_FROM_A_HEIGHT_QUESTION,
      MAXIMUM_HEIGHT_QUESTION
    ],
    # 'Silage pit clamping' => []
    # 'Strimming' => []
    'Welding' => [
      OWN_EQUIPMENT_QUESTION,
      WORK_FROM_A_HEIGHT_QUESTION,
      MAXIMUM_HEIGHT_QUESTION
    ],
    # 'Yard Scaping' => []
    # 'Other' => []
    # SERVICE: 'Picking'
    'Fruit Picking' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What type of fruit?",
        options: ["Apples", "Blackcurrants", "Cherries", "Pears", "Plums", "Raspberries", "Strawberries", "Other"]
      },
      WORK_FROM_A_HEIGHT_QUESTION,
      MAXIMUM_HEIGHT_QUESTION,
      AREA_QUESTION
    ],
    'Stone Picking' => [
      AREA_QUESTION
    ],
    'Vegetable Picking' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What type of vegetables?",
        options: ["Broccoli", "Cabbage", "Carrots", "Cauliflower", "Kale", "Leek", "Lettuce", "Onion", "Peas", "Rhubarb", "Turnip", "Other"]
      },
      AREA_QUESTION
    ],
    # SERVICE: 'Machinery Driving & Operation'
    'Large Machinery Driving & Operation' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What type of machine is required to be driven?",
        options: ["Combine Harvester", "Forage harvester", "Self propelled mower", "Self propelled sprayer", "Other"]
      },
      {
        kind: :unit_and_value,
        wording: "Estimated lenght of time required?",
        options: ["Days", "Weeks"]
      }
    ],
    'Tractor Driving & Operation' => [
      {
        kind: :multiple_choice_with_other,
        wording: "What is the main type of work to be carried out?",
        options: ["Loader Work", "Tractor and Trailer/dumper", "Tractor & Farm implement", "Other"]
      },
      {
        kind: :unit_and_value,
        wording: "Estimated lenght of time required?",
        options: ["Days", "Weeks"]
      }
    ]
  }

  # For multiple_choice_with_effect_on_next questions.
  # The outer keys in the hash are the questions, and the inner keys the possible answers
  # which map to the options for the follow up question.
  FOLLOW_UP_OPTIONS =  { "What type of bale do you want?" => {"Round" => ["Round 120cm", "Round 150cm"], "Square" => ["Square - 120x130cm", "Square - 120x70cm", "Square - 120x90cm", "Square - 80x90cm", "Square - Small Conventional"]}}

  def generate_questions_for_service(service)
    QUESTIONS[service.name].map do |question_attrs|
      service.questions.create!(question_attrs)
    end
  end
end

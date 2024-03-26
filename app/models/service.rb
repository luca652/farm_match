class Service < ApplicationRecord
  belongs_to :job

  SERVICES = {
    'Application (Spraying and Spreading)' => ['Fertilizer Spreading', 'Lime Spreading', 'Spraying (specialised)', 'Spraying (standard)'],
    'Drilling and Sowing' => ['Cereals - Drilling', 'Grass Seed - Drilling', 'Maize - Drilling', 'Oil Seed Rape - Drilling',
                            'Potatoes - Drilling', 'Sugar Beet - Drilling', 'Vegetables - Drilling'],
    'Fencing and Hedging' => ['Fence Erection', 'Hedge Laying', 'Verge Bank Mowing'],
    'Grassland Harvesting' => ['Baling - FULL SERVICE (Mow, Ted/Rake, Bale, Wrap, Transport etc)', 'Mowing', 'Tedding',
                               'Raking', 'Baling', 'Wrapping', 'Bale Chasing/Haulage', 'Topping',
                               'Silage Harvesting - Complete Service (wholecrop, Harvesting, trailers, pit building, clamping)',
                               'Silage Harvesting - Harvesting, trailers, Pit building, clamping', 'Silage Harvesting only',
                               'Forage Wagon - Complete Service (Wholecrop, Pit Building, Clamping)',
                               'Forage Wagon - Harvesting, Pit Building and Clamping', 'Forage Wagon - Harvesting only',
                               'Maize Harvesting - Complete Service (wholecrop, Harvesting, trailers, pit building, clamping)',
                               'Maize Harvesting - Harvesting, trailers, Pit building, clamping', 'Maize Harvesting only'],
    'Crop Harvesting' => ['Beet Harvesting', 'Cereal Harvesting', 'Potato Harvesting', 'Vegtable Harvesting'],
    'Hedge Cutting' => ['Hedge cutting - Saw', 'Hedge cutting - Flail'],
    'Machine and Tractor Hire' => ['Forklift Hire', 'Loader Hire', 'Tractor Hire', 'Teleporter Hire'],
    'Maize Harvesting' => ['Maize Harvesting - Complete Service (wholecrop, Harvesting, trailers, pit building, clamping)',
                           'Maize Harvesting - Harvesting, trailers, Pit building, clamping', 'Maize Harvesting only'],
    'Mobile feeding' => ['Milling/Mixing', 'Grain Crimping'],
    'Muck and Slurry' => ['Muck Spreading', 'Muck Haulage', 'Slurry Spreading'],
    'Painting and Powerwashing' => ['Painting', 'Powerwashing'],
    'Soil Preparation' => ['Bed tilling', 'Harrowing', 'Land levelling', 'One pass tillage train', 'Ploughing', 'Pressing/Cultipress',
                          'Rolling', 'Rotavating', 'Stubble Raking'],
    'Tree Cutting and Forestry' => ['Chainsaw & Operator', 'Timber Harvesting'],
    'Plant Hire and Earthworks' => ['Plant Hire (Self Drive)', 'Escavation & Sitework', 'Land Clearing', 'Land Drainage', 'Tree Stump Removal',
                                    'Ditch removal', 'Roadways', 'Land Levelling', 'Stone Removal'],
    'Animal Care' => ['Castration', 'Crutching (Dagging)', 'De-horning', 'Dipping', 'Docking (tail removal)', 'Dosing', 'Feeding',
                      'Foot Trimming', 'Injection', 'Lambing/Calfing/Animal Birthing', 'Shearing', 'Shifting/Loading Livestock', 'Tagging',
                      'Testing'],
    'Milking' => ['Milking'],
    'General Yard Duties' => ['Cleaning/Power Washing', 'Construction', 'Machinery Maintenance', 'Mucking out sheds', 'Painting',
                              'Silage pit clamping', 'Strimming', 'Welding', 'Yard Scaping', 'Other'],
    'Picking' => ['Fruit Picking', 'Stone Picking', 'Vegetable Picking'],
    'Machinery Driving and Operation' => ['Large Machinery Driving & Operation', 'Tractor Driving & Operation']
  }.freeze
  SERVICES.values.each(&:freeze)

end

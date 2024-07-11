class Task < ApplicationRecord

  CATEGORIES = ['Agri Contracting',
                'Forestry',
                'Plant Hire & Earthworks',
                'Farm Labour'].freeze
  CATEGORIES.each(&:freeze)

  SUBCATEGORIES = {
    'Agri Contracting' => ['Application (Spraying & Spreading)',
                           'Drilling & Sowing',
                           'Fencing & Hedging',
                           'Grassland Harvesting',
                           'Crop Harvesting',
                           'Hedge Cutting',
                           'Machine & Tractor Hire',
                           'Maize Harvesting',
                           'Mobile feeding',
                           'Muck & Slurry',
                           'Painting & Powerwashing',
                           'Soil Preparation'],
    'Forestry' => ['Tree Cutting & Forestry'],
    'Plant Hire & Earthworks' => ['Plant Hire & Earthworks'],
    'Farm Labour'=> ['Animal Care',
                    'Milking',
                    'General Yard Duties',
                    'Picking',
                    'Machinery Driving & Operation']
  }.freeze
  SUBCATEGORIES.values.each(&:freeze)

  belongs_to :user
  has_many :services, dependent: :destroy
  accepts_nested_attributes_for :services, allow_destroy: true

  validates :category, :subcategory, :headline, :description, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :subcategory, inclusion: { in: SUBCATEGORIES.values.flatten }
  # inclusion expects an array, but SUBCATEGORIES.values returns an array of arrays --> flatten solves the issue

  validates :services, presence: true
  validate :valid_subcategory_for_category
  validate :location_is_present


  def valid_subcategory_for_category
    return if category.blank? || subcategory.blank?

    valid_subcategories = SUBCATEGORIES[category]
    unless valid_subcategories.include?(subcategory)
      errors.add(:subcategory, "is not valid for the selected category")
    end
  end

  def location_is_present
    if latitude.blank? || longitude.blank?
      errors.add(:base, "Location can't be blank")
    end
  end
end

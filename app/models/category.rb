class Category < ActiveRecord::Base
  include Sluggable
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: {minimum: 2}
  validates_uniqueness_of :name, case_sensitive: false

  sluggable_column :name


end
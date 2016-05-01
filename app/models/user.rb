class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  validates :password, presence: true, on: :create

  sluggable_column :username


  #######
  ### ROLES
  ######
  def is_admin?
    self.role == "admin"
  end

end
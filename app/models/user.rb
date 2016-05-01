class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  sluggable_column :username


  #######
  ### ROLES
  ######
  def is_admin?
    self.role == "admin"
  end

end
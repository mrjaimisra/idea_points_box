class User < ActiveRecord::Base
  extend ActiveModel::Naming

  has_secure_password

  validates :username, presence: true, uniqueness: true

end

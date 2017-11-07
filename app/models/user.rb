class User < ApplicationRecord
  
  has_secure_password

  has_many :tasks
  
  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: {case_sensitive: true}
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
    message: "write a valid email format" }
end

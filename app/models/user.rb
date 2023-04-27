  class User < ApplicationRecord
      
    before_save { self.email = email.downcase }
      validates :username, presence: true, uniqueness: { case_sensitive: false }
      validates :email, presence: true, uniqueness: { case_sensitive: false }, 
      format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }, 
      length: { maximum: 105 }
      has_many :articles, dependent: :destroy  
      has_secure_password
      has_one_attached :image
    validates :image, presence: { message: "must be present" }
    
  end
    
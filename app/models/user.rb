  class User < ApplicationRecord
      has_many :articles  
      validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..25 }
      validates :email, presence: true, uniqueness: { case_sensitive: false }, 
      format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }, 
      length: { maximum: 105 }
    
  end
    
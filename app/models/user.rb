require 'csv'
require 'faker'
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


    def self.to_csv
      attributes = %w{id username email admin created_at updated_at testing}
  
      CSV.generate(headers: true) do |csv|
        csv << attributes
  
        all.each do |user|
          testing = Faker::Time.between(from: '2021-01-01', to: Time.zone.now)
          csv << attributes.map{ |attr| attr == 'testing' ? testing : user.send(attr) }
        end
      end
    end
    
  end
    
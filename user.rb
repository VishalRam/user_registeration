class User < ActiveRecord::Base

  attr_accessible :id, :email, :password, :registration_type

  validates :email, presence: true, allow_blank: false
  validates :password, presence: true, allow_blank: false
  validates :registration_type, presence: true, allow_blank: false

  before_save :validate_type

  def self.register(params)
    if User.where(email: params['email'], password: params["password"]).first.present?
      return "User already registered !!"
    else
      self.create!(email: params["email"], password: params["password"], registration_type: params["type"])
      return "User registered successfully !!"
    end
  end

  def validate_type
    self.registration_type == "web" or self.registration_type == "social" or self.registration_type == "mobile"
  end

  def self.login(params)
    User.where(email: params['email'], password: params["password"]).first
  end

end

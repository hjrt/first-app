class User < ApplicationRecord

  attr_accessor :login, :avatar
    
  has_many :questions
  has_many :answers
  has_many :likes

  #carrierwave
  mount_uploader :avatar, AvatarUploader

  #validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar
  #validates :avatar, file_size: { less_than: 1.megabytes }

  # devise
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  } 

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
     
  def email_required?
    false
  end

  def email_changed?
    false
  end

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  # attr_accessor :login

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  # devise omniauth

  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end

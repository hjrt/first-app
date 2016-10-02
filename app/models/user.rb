class User < ApplicationRecord

  attr_accessor :login, :avatar

  has_many :questions
  has_many :answers
  has_many :likes
  has_and_belongs_to_many :badges
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
    has_many :incoming_friend_requests,
    class_name: 'FriendRequest',
    source: :friend

  #carrierwave
  mount_uploader :avatar, AvatarUploader

  validates_integrity_of  :avatar
  validates_processing_of :avatar
  validates :avatar, file_size: { less_than: 1.megabytes }

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

  validates_uniqueness_of :username
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

    
  # points system
  def manage_points(points)
    self.points += points
    self.points

    add_badges_if_any
  end

  # badges 
  def add_badges_if_any
      if self.points >= 1000
        self.badges << Badge.find_by_name('Superstar Alpaca')
        self.save
      elsif self.points >= 500
        self.badges << Badge.find_by_name('Regular Alpaca')
        self.save
      elsif self.points >= 100
        self.badges << Badge.find_by_name('Disappointing Alpaca')
        self.save
      end
  end
  
# friends

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end


end

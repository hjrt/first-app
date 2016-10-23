class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'


  def self.request(user, friend)
    unless user == friend and user.are_friends?(friend)
      transaction do
        create(:user => user, :friend => friend, :status => 'pending')
        create(:user => friend, :friend => user, :status => 'requested')
      end
    end
  end

  def self.accept(user, friend)
    transaction do
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  def self.accept_one_side(user, friend)
    request = self.find_by_user_id_and_friend_id(user.id, friend.id)
    request.status = 'accepted'
    request.save!
  end


  def self.destroy(user, friend)
    transaction do
      destroy_one_side(user, friend)
      destroy_one_side(friend, user)
    end
  end

  def self.destroy_one_side(user, friend)
    request = self.find_by_user_id_and_friend_id(user.id, friend.id)
    request.destroy
  end

end
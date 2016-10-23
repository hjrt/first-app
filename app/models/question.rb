class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, presence: true

  def to_param
    "#{id} #{title}".parameterize
  end

end

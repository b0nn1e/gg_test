class Customer < ApplicationRecord
  has_and_belongs_to_many :campaigns
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  def campaigns_ordered
    campaigns.ordered
  end
end

class Recipient < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }
end

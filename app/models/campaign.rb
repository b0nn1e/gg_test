# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_and_belongs_to_many :recipients

  validates :subject, :message, :recipients, presence: true
end

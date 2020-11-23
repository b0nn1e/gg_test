# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_and_belongs_to_many :customers

  validates :subject, :message, :customers, presence: true

  scope :ordered, -> { order(created_at: :asc) }
end

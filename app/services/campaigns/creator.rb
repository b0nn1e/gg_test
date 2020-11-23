# frozen_string_literal: true

module Campaigns
  class Creator < ApplicationService
    EMAILS_DELIMITER = ','
    attr_accessor :subject, :message, :emails

    validates :subject, :message, :emails, presence: true

    def initialize(args)
      super
      self.subject = args[:subject]&.strip || ''
      self.message = args[:message]&.strip || ''
      self.emails = args[:emails] || []
    end

    def call
      campaign = Campaign.new(subject: subject, message: message)
      campaign.customers = create_customers
      if campaign.valid?
        campaign.save
        ProcessCampaignJob.perform_later(campaign_id: campaign.id)
        true
      else
        add_errors(campaign.errors) unless campaign.valid?
      end
    end

    private

    def create_customers
      customers = []
      normalized_emails.each do |email|
        service = ::Customers::Creator.call(email: email)
        if service.success?
          customers.push(service.response)
        else
          errors.add(:emails, "'#{email}' is invalid")
        end
      end
      customers
    end

    def normalized_emails
      return emails.compact if emails.is_a?(Array)

      emails.split(EMAILS_DELIMITER).compact
    end
  end
end

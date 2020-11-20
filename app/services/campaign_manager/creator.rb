# frozen_string_literal: true

module CampaignManager
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
      camping = Campaign.new(subject: subject, message: message)
      camping.recipients = create_recipients
      if camping.valid?
        camping.save
      else
        add_errors(camping.errors) unless camping.valid?
      end
    end

    private

    def create_recipients
      recipients = []
      normalized_emails.each do |email|
        service = ::RecipientManager::Creator.call(email: email)
        if service.success?
          recipients.push(service.response)
        else
          errors.add(:emails, "'#{email}' is invalid")
        end
      end
      recipients
    end

    def normalized_emails
      return emails.compact if emails.is_a?(Array)

      emails.split(EMAILS_DELIMITER).compact
    end
  end
end

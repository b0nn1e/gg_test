require_relative 'providers/sendgrid'
require_relative 'providers/mailgun'

module GrandEmailProvider
  class Sender
    MAX_TRY_COUNT = 3
    attr_accessor :email, :subject, :message

    PROVIDERS = [
      Providers::Mailgun.new,
      Providers::Sendgrid.new
    ].freeze

    def initialize(email, subject, message)
      self.email = email
      self.subject = subject
      self.message = message
    end

    def send_email
      success = false
      trying = 0
      loop do
        trying += 1
        PROVIDERS.each do |provider|
          begin
            success = provider.send_email(email, subject, message)
          rescue => e
            success = false
            Rails.logger.error(e)
          end
          break if success
        end
        break if success || trying == MAX_TRY_COUNT
      end
    end
  end
end

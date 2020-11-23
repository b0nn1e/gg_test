require 'mailgun'
require_relative 'base'

module GrandEmailProvider
  module Providers
    class Mailgun < Base
      attr_accessor :client, :domain

      def initialize
        super

        credentials = Rails.application.credentials.mailgun
        self.client = credentials[:key]
        self.domain = credentials[:domain]
      end

      def send_email(email, subject, message)
        message_params = {
          from: from_email,
          to: email,
          subject: subject,
          text: message
        }

        result = client.send_message(domain, message_params).to_h!
        result['id'].present?
      end
    end
  end
end

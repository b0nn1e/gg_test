require 'sendgrid-ruby'
require_relative 'base'

module GrandEmailProvider
  module Providers
    class Sendgrid < Base
      include SendGrid
      attr_accessor :api_key

      def initialize
        super
        # TODO: move to secrets
        self.api_key = 'FAKE_SENDGRID_API_KEY'
      end

      def send_email(email, subject, message)
        from = SendGrid::Email.new(email: from_email)
        to = SendGrid::Email.new(email: email)
        content = SendGrid::Content.new(type: 'text/plain', value: message)
        mail = SendGrid::Mail.new(from, subject, to, content)

        sg = SendGrid::API.new(api_key: api_key)
        response = sg.client.mail._('send').post(request_body: mail.to_json)
        puts response.status_code
        response.status_code == 200
      end
    end
  end
end

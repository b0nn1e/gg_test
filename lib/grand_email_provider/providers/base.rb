module GrandEmailProvider
  module Providers
    class Base
      FROM_EMAIL = 'no-reply@myservice.com'.freeze

      def send_email(_email, _subject, _message)
        raise NotImplementedError
      end

      def from_email
        FROM_EMAIL
      end
    end
  end
end

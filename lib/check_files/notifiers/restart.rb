# frozen_string_literal: true

module CheckFiles
  module Notifiers
    class Restart < Logging
      def self.call(checker)
        $stderr << "\n\e[0;31m=> #{checker.pattern} has changed, so the web server was restarted. Please reload the page.\e[0m\n" # rubocop:disable Metrics/LineLength
        system "rails restart"
      end
    end
  end
end

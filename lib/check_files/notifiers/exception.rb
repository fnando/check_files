# frozen_string_literal: true

module CheckFiles
  module Notifiers
    class Exception
      def self.call(checker)
        raise "You must restart the web development server; #{checker.pattern} has changed." # rubocop:disable Metrics/LineLength
      end
    end
  end
end

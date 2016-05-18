module CheckFiles
  module Notifiers
    class Exception
      def self.call(checker)
        fail "You must restart the web development server; #{checker.pattern} has changed."
      end
    end
  end
end

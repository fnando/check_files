module CheckFiles
  module Notifiers
    class Logging
      def self.call(checker)
        $stderr << "\n\e[0;31m=> You must restart your web development server; #{checker.pattern} has changed.\e[0m\n"
      end
    end
  end
end

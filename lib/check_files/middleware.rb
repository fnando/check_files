# frozen_string_literal: true

module CheckFiles
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      CheckFiles.check! unless asset?(env)
      @app.call(env)
    end

    def asset?(env)
      env["REQUEST_PATH"] =~ /\.(css|js|jpe?g|gif|svg|ico|swf|html)/
    end
  end
end

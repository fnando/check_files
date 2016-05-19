require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "bundler/setup"

require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "check_files"
require "check_files/railtie"

Bundler.require(*Rails.groups)

require "minitest/utils"
require "minitest/autorun"

FileUtils.mkdir_p "tmp/cache"
FileUtils.mkdir_p "tmp/files"

class Application < Rails::Application
  config.eager_load = false
  config.active_support.test_order = :random
  config.secret_token = SecureRandom.hex(100)
  config.secret_key_base = SecureRandom.hex(100)
end

Rails.application.initialize!

Rails.application.routes.draw do
  root to: -> env { [200, {"Content-Type" => "text/html"}, []] }
end

module Minitest
  class Test
    setup do
      Dir["tmp/cache/*"].each {|file| File.unlink(file) }
      Dir["tmp/files/*"].each {|entry| FileUtils.rm_rf(entry) }
    end

    def save_file(path, contents = "")
      File.open(path, "w") {|io| io << contents }
    end

    def remove_file(path)
      File.unlink(path)
    end

    def create_dir(path)
      FileUtils.mkdir_p(path)
    end

    def read_file(path)
      File.read(path)
    end

    def sha1(input)
      Digest::SHA1.hexdigest(input).to_s
    end
  end
end

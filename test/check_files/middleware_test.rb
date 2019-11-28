# frozen_string_literal: true

require "test_helper"

class MiddlewareTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Rails.application
  end

  setup do
    CheckFiles.reset
    Rails.configuration.check_files.paths << "tmp/files/file.txt"
  end

  teardown do
    Rails.configuration.check_files.paths.pop
    Rails.configuration.check_files.notifier = CheckFiles::Notifiers::Exception
    remove_file("tmp/files/file.txt")
  end

  test "checks for changes" do
    CheckFiles.expects(:check!)

    get "/"
  end

  test "ignores assets" do
    CheckFiles.stubs(:check!).raises("Should not be called")

    get "/image.svg"
  end
end

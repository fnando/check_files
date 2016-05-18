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

  test "returns error when something changes" do
    get "/"
    assert_equal 200, last_response.status

    save_file("tmp/files/file.txt", "a")

    get "/"
    assert_equal 500, last_response.status
  end
end

# frozen_string_literal: true

require "test_helper"

class CheckFilesTest < Minitest::Test
  setup do
    CheckFiles.reset
    Rails.configuration.check_files.paths << "tmp/files/file.txt"
  end

  teardown do
    Rails.configuration.check_files.paths.pop
    Rails.configuration.check_files.notifier = CheckFiles::Notifiers::Exception
    remove_file("tmp/files/file.txt")
  end

  test "raises exception when something changes" do
    assert_raises RuntimeError do
      Rails.configuration.check_files.notifier =
        CheckFiles::Notifiers::Exception

      CheckFiles.check!
      save_file("tmp/files/file.txt", "a")
      CheckFiles.check!
    end
  end

  test "logs message when something changes" do
    Rails.configuration.check_files.notifier = CheckFiles::Notifiers::Logging

    _, err = capture_io do
      CheckFiles.check!
      save_file("tmp/files/file.txt", "b")
      CheckFiles.check!
    end

    assert err.include?("=> You must restart your web development server; tmp/files/file.txt has changed.") # rubocop:disable Metrics/LineLength
  end
end

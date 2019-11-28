# frozen_string_literal: true

require "rails/railtie"
require "fileutils"

module CheckFiles
  require "check_files/version"
  require "check_files/railtie"
  require "check_files/middleware"
  require "check_files/checker"
  require "check_files/notifiers/logging"
  require "check_files/notifiers/exception"
  require "check_files/notifiers/restart"

  def self.config
    Rails.application.config.check_files
  end

  def self.checkers
    @checkers ||= config.paths.map {|path| Checker.new(path) }
  end

  def self.reset
    @checkers = nil
  end

  def self.check!
    change = checkers.find(&:changed?)
    config.notifier.call(change) if change
  end
end

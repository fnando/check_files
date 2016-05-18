require "test_helper"

class CheckerTest < Minitest::Test
  test "changes when file is added" do
    checker = CheckFiles::Checker.new("tmp/files/file.txt")
    refute checker.changed?

    save_file("tmp/files/file.txt")
    assert checker.changed?
  end

  test "changes when file is removed" do
    save_file("tmp/files/file.txt")

    checker = CheckFiles::Checker.new("tmp/files/file.txt")
    refute checker.changed?

    remove_file("tmp/files/file.txt")
    assert checker.changed?
  end

  test "changes when file content changes" do
    save_file("tmp/files/file.txt")

    checker = CheckFiles::Checker.new("tmp/files/file.txt")
    refute checker.changed?

    save_file("tmp/files/file.txt", "changed")
    assert checker.changed?
  end

  test "changes when entries list changes" do
    checker = CheckFiles::Checker.new("tmp/files/*")
    refute checker.changed?

    create_dir("tmp/files/a")
    assert checker.changed?
  end

  test "updates cache" do
    path = "tmp/files/file.txt"
    cache_path = File.join("tmp/cache", sha1(path))
    save_file(path, "a")
    checker = CheckFiles::Checker.new(path)
    checker.update_cache
    digest = File.read(cache_path)

    assert File.file?(cache_path)

    save_file(path, "b")
    checker.update_cache

    refute_equal digest, read_file(cache_path)
  end
end

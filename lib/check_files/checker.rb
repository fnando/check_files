module CheckFiles
  class Checker
    attr_reader :cache_path, :pattern

    def initialize(pattern)
      @pattern = pattern
      pattern_digest = Digest::SHA1.hexdigest(pattern)
      @cache_path = Rails.root.join("tmp/cache/#{pattern_digest}")
    end

    def current_digest
      entries = Dir[pattern].sort
      entries_digest = Digest::SHA1.hexdigest(entries.join)

      if pattern.end_with?("/*")
        entries_digest
      else
        content_digest = entries.map {|entry| compute_digest(entry) }.join
        Digest::SHA1.hexdigest("#{entries_digest}#{content_digest}")
      end
    end

    def previous_digest
      cache_path.file? && cache_path.read
    end

    def changed?
      prev_digest = previous_digest

      if prev_digest
        prev_digest != current_digest
      else
        update_cache && false
      end
    end

    def update_cache
      File.open(cache_path, "w") {|f| f << current_digest }
    end

    def compute_digest(entry)
      content = File.exist?(entry) && File.read(entry)
      Digest::SHA1.hexdigest("#{entry}-#{content}")
    end
  end
end

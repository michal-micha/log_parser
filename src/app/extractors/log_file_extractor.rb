# frozen_string_literal: true

class LogFileExtractor
  class InvalidLineFormatError < StandardError; end

  def initialize
    @hash_with_total_views_count = Hash.new(0)
    @hash_with_unique_views_count = {}
  end

  def extract(log_file)
    IO.foreach(log_file) do |line|
      page_path, ip_address = split_valid_file_line(line)

      increment_view_total_count(page_path)
      instantiate_unique_views_set(page_path)
      append_pages_unique_view(page_path, ip_address)
    end

    [hash_with_total_views_count, hash_with_unique_views_count]
  end

  private

  attr_reader :hash_with_total_views_count, :hash_with_unique_views_count

  def split_valid_file_line(line)
    line.split.tap do |elements|
      raise InvalidLineFormatError if elements.size != 2
    end
  end

  def increment_view_total_count(page_path)
    hash_with_total_views_count[page_path] += 1
  end

  def instantiate_unique_views_set(page_path)
    hash_with_unique_views_count[page_path] ||= Set.new
  end

  def append_pages_unique_view(page_path, ip_address)
    hash_with_unique_views_count[page_path] << ip_address
  end
end

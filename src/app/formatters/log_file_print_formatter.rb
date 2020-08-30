# frozen_string_literal: true

class LogFilePrintFormatter
  def call(total_views_hash, unique_views_hash)
    total_views_hash = sort_by_total_views_desc_and_page_path(total_views_hash)
    print_list_of_total_views(total_views_hash)

    unique_views_hash = sort_by_unique_views_size_desc_and_page_path(unique_views_hash)
    print_list_of_unique_views(unique_views_hash)
  end

  private

  def sort_by_total_views_desc_and_page_path(total_views_hash)
    total_views_hash.sort_by { |page_path, count| [-count, page_path] }
  end

  def print_list_of_total_views(total_views_hash)
    puts '1. List of webpages with most page views'

    total_views_hash.each do |page_path, count|
      puts "#{page_path} #{count} visits"
    end
  end

  def sort_by_unique_views_size_desc_and_page_path(unique_views_hash)
    unique_views_hash.transform_values!(&:size)
                     .sort_by { |page_path, unique_views_count| [-unique_views_count, page_path] }
  end

  def print_list_of_unique_views(unique_views_hash)
    puts '2. List of webpages with most unique page views'

    unique_views_hash.each do |page_path, unique_views_count|
      puts "#{page_path} #{unique_views_count} visits"
    end
  end
end

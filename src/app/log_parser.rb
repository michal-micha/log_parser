#!/usr/bin/env ruby

# frozen_string_literal: true

require 'set'
require_relative 'extractors/log_file_extractor'
require_relative 'formatters/log_file_print_formatter'
require_relative 'validators/log_file_validator'

class LogParser
  def initialize(log_file: nil, validator: nil, extractor: nil, print_formatter: nil)
    @log_file = log_file
    @validator = validator || LogFileValidator.new
    @extractor = extractor || LogFileExtractor.new
    @print_formatter = print_formatter || LogFilePrintFormatter.new
  end

  def call
    abort 'Log file is too large or has invalid format' unless validator.valid?(log_file)

    page_views_count, unique_ip_views_count = extractor.extract(log_file)
    print_formatter.call(page_views_count, unique_ip_views_count)
  end

  private

  attr_reader :log_file, :validator, :extractor, :print_formatter
end

# To test LogParser class definition in this file with Rspec
LogParser.new(log_file: ARGV[0]).call if $PROGRAM_NAME == __FILE__

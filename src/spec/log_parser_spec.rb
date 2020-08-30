# frozen_string_literal: true

require_relative '../app/log_parser'

RSpec.describe LogParser do
  describe '.call' do
    subject do
      described_class.new(
        log_file: log_file_path,
        validator: validator_double,
        extractor: extractor_double,
        print_formatter: print_formatter
      ).call
    end

    include_context 'with valid total_views and unique_views standard data'

    let(:log_file_path) { 'spec/support/fixtures/standard_log_file.log' }
    let(:validator_double) { instance_double(LogFileValidator, valid?: log_file_valid) }
    let(:extractor_double) { instance_double(LogFileExtractor) }
    let(:print_formatter) { LogFilePrintFormatter.new }

    let(:extracted_data) { [standard_total_views_hash, standard_unique_views_hash] }
    let(:expected_printed_lists) do
      <<~HEREDOC
        1. List of webpages with most page views
        /about/2 90 visits
        /contact 89 visits
        /index 82 visits
        /about 81 visits
        /help_page/1 80 visits
        /home 78 visits
        2. List of webpages with most unique page views
        /contact 23 visits
        /help_page/1 23 visits
        /home 23 visits
        /index 23 visits
        /about/2 22 visits
        /about 21 visits
      HEREDOC
    end

    before do
      allow(extractor_double).to receive(:extract).with(log_file_path).and_return(extracted_data)
      allow(print_formatter).to receive(:call).with(*extracted_data).and_call_original
    end

    context 'when log_file is valid' do
      let(:log_file_valid) { true }

      it 'prints message with both lists' do
        expect { subject }.to output(expected_printed_lists).to_stdout
        expect(extractor_double).to have_received(:extract)
        expect(print_formatter).to have_received(:call)
      end
    end

    context 'when log_file is invalid' do
      let(:log_file_valid) { false }

      it 'aborts script with error message' do
        expect { subject }.to raise_error(SystemExit, 'Log file is too large or has invalid format')
        expect(extractor_double).not_to have_received(:extract)
      end
    end
  end
end

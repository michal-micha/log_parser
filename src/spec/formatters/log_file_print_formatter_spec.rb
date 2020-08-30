# frozen_string_literal: true

require_relative '../../app/formatters/log_file_print_formatter'

RSpec.describe LogFilePrintFormatter do
  describe '.call' do
    subject { described_class.new.call(total_views_hash, unique_views_hash) }

    context 'when input hashes are empty' do
      let(:total_views_hash) { {} }
      let(:unique_views_hash) { {} }

      # Returning hardcoded 2 bulletpoints is probably not ideal, was used for purpose
      # off this recruitment task to ensure that unhappy path is not broken.
      # Another possibility was to raise exception instead.
      let(:description_without_list) do
        <<~HEREDOC
          1. List of webpages with most page views
          2. List of webpages with most unique page views
        HEREDOC
      end

      it do
        expect { subject }.to output(description_without_list).to_stdout
      end
    end

    context 'when input hashes include valid data' do
      include_context 'with valid total_views and unique_views small data'

      let(:expected_printed_lists) do
        <<~HEREDOC
          1. List of webpages with most page views
          /contact 2 visits
          /index 2 visits
          /home 1 visits
          2. List of webpages with most unique page views
          /contact 2 visits
          /home 1 visits
          /index 1 visits
        HEREDOC
      end

      it do
        expect { subject }.to output(expected_printed_lists).to_stdout
      end
    end
  end
end

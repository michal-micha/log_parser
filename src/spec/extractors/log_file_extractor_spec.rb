# frozen_string_literal: true

require_relative '../../app/extractors/log_file_extractor'

RSpec.describe LogFileExtractor do
  describe '.extract' do
    subject { described_class.new.extract(log_file_path) }

    context "when file's content has valid format" do
      include_context 'with valid total_views and unique_views small data'

      let(:log_file_path) { 'spec/support/fixtures/small_log_file.log' }
      let(:expected_output) { [total_views_hash, unique_views_hash] }

      it 'returns array of hashes with total and unique views count' do
        expect(subject).to eq(expected_output)
      end
    end

    context "when file's content does NOT have valid format" do
      let(:log_file_path) { 'spec/support/fixtures/file_with_invalid_extension.txt' }

      it 'raises InvalidLineFormatError' do
        expect { subject }.to raise_error(LogFileExtractor::InvalidLineFormatError)
      end
    end
  end
end

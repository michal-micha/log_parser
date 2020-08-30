# frozen_string_literal: true

require_relative '../../app/validators/log_file_validator'

RSpec.describe LogFileValidator do
  describe '.valid?' do
    subject { described_class.new.valid?(log_file_path) }

    context 'when file has correct extension and small enough size' do
      let(:log_file_path) { 'spec/support/fixtures/standard_log_file.log' }

      it { is_expected.to eq true }
    end

    context 'when file has invalid extension' do
      let(:log_file_path) { 'spec/support/fixtures/file_with_invalid_extension.txt' }

      it { is_expected.to eq false }
    end

    context "when file's size is too big" do
      let(:log_file_path) { 'spec/support/fixtures/large_log_file.log' }

      it { is_expected.to eq false }
    end
  end
end

# frozen_string_literal: true

RSpec.describe UndriveGoogle::CaptiveFile do
  subject(:instance) { described_class.instance }

  describe ".instance" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end

  describe ".liberate!" do
    subject(:liberate) { instance.liberate! }

    include_context "with google session" do
      before do
        allow(double_file).to receive(:export_as_file).with("/My_Title.docx", "docx")
        file_types = (UndriveGoogle::FILE_TYPES - [:zip])
        file_types.each do |type|
          allow(double_file).to receive(:export_as_file).with("/My_Title.#{type}", type)
        end
        UndriveGoogle::Options.instance.extensions = file_types
      end
    end

    it "does not raise error" do
      block_is_expected.not_to raise_error
    end
  end
end

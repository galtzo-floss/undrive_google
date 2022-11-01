# frozen_string_literal: true

RSpec.describe UndriveGoogle::CLI do
  subject(:instance) { described_class.instance }

  describe ".instance" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end

  describe "#liberate!" do
    subject(:liberate) { instance.liberate! }

    include_context "with google session" do
      before do
        file_types = (UndriveGoogle::DL_FILE_TYPES - [:zip])
        file_types.each do |type|
          allow(double_file).to receive(:export_as_file).with("/My_Title.#{type}", type)
        end
        extensions = file_types.join(",")
        instance.parse(["--no-verbose", "--extensions=#{extensions}"])
      end
    end

    it "does not raise error" do
      block_is_expected.not_to raise_error
    end

    it "liberates the captive" do
      allow(UndriveGoogle::CaptiveFile.instance).to receive(:liberate!)
      liberate
      expect(UndriveGoogle::CaptiveFile.instance).to have_received(:liberate!)
    end
  end
end

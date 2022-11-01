# frozen_string_literal: true

RSpec.describe UndriveGoogle::Transformations::DeleteZip do
  subject(:instance) { described_class.new(file_path) }

  let(:file_path) { "tml/my.zip" }

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end

  describe "#process" do
    subject(:process) { instance.process }

    it "Deletes file" do
      allow(File).to receive(:delete).with(file_path)
      process
      expect(File).to have_received(:delete).with(file_path)
    end
  end
end

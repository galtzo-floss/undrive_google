# frozen_string_literal: true

RSpec.describe UndriveGoogle::Transformations::Unzip do
  subject(:instance) { described_class.new(file_path, destination) }

  let(:file_path) { "spec/fixtures/fake.zip" }
  let(:destination) { "spec/tmp/fake" }

  let(:parser) { OptionParser.new }
  let(:args) { ["--no-verbose"] }

  before do
    UndriveGoogle::Options.instance.define_options(parser)
    parser.parse!(args)
  end

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
    context "without destination specified" do
      let(:destination) { nil }

      it "does not error" do
        block_is_expected.not_to raise_error
      end
    end
  end

  describe "#process" do
    subject(:process) { instance.process }
    let(:args) { ["-u", "--no-verbose"] }

    it "Unzips file" do
      allow(Zip::File).to receive(:open).with(file_path)
      process
      expect(Zip::File).to have_received(:open).with(file_path)
    end

    context "without destination specified" do
      let(:destination) { nil }

      it "Unzips file" do
        allow(Zip::File).to receive(:open).with(file_path)
        process
        expect(Zip::File).to have_received(:open).with(file_path)
      end
    end

    context "without unzip" do
      let(:args) { ["--no-unzip"] }

      it "Does not unzip file" do
        allow(Zip::File).to receive(:open)
        process
        expect(Zip::File).to_not have_received(:open)
      end
    end

    context "with verbose" do
      let(:args) { ["--unzip", "--verbose"] }

      before do
        UndriveGoogle::Options.instance.define_options(parser)
        parser.parse!(args)
      end

      it "Unzips file" do
        allow(Zip::File).to receive(:open).with(file_path)
        process
        expect(Zip::File).to have_received(:open).with(file_path)
      end
    end
  end
end

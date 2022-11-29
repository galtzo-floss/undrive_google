# frozen_string_literal: true

RSpec.describe UndriveGoogle::Transformations::Unzip do
  subject(:instance) { described_class.new(file_path, destination) }

  let(:file_path) { "spec/fixtures/Peter_Boling_Resume_2022.11.29.zip" }
  let(:destination) { "spec/tmp/unzip_integration" }

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
  end

  describe "#process" do
    subject(:process) { instance.process }
    let(:args) { ["-u", "--no-verbose"] }

    it "Unzips file" do
      allow(Zip::File).to receive(:open).with(file_path).and_call_original
      process
      expect(Zip::File).to have_received(:open).with(file_path)
    end

    context "without unzip" do
      let(:args) { ["--no-unzip"] }

      it "Does not unzip file" do
        allow(Zip::File).to receive(:open)
        process
        expect(Zip::File).to_not have_received(:open)
      end

      it "does not set html_path" do
        block_is_expected.to_not change(instance, :html_path).from(nil)
      end
    end

    context "with verbose" do
      let(:args) { ["--unzip", "--verbose"] }

      before do
        UndriveGoogle::Options.instance.define_options(parser)
        parser.parse!(args)
      end

      it "Unzips file" do
        allow(Zip::File).to receive(:open).with(file_path).and_call_original
        process
        expect(Zip::File).to have_received(:open).with(file_path)
      end

      it "sets html_path" do
        block_is_expected.to change(instance, :html_path).from(nil).to("spec/tmp/unzip_integration/PeterBolingResume2022.11.29.html")
      end
    end
  end
end

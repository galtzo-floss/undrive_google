# frozen_string_literal: true

RSpec.describe UndriveGoogle::Actions::Liberate do
  subject(:instance) { described_class.new(extension) }

  let(:extension) { "txt" }
  let(:parser) { OptionParser.new }
  let(:dir) { "tmp" }
  let(:args) { ["-d", dir] }

  include_context "with google session"

  before do
    UndriveGoogle::Options.instance.define_options(parser)
    parser.parse!(args)
  end

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end

    it "is expected to set dir" do
      expect(instance.dir).to eq dir
    end
  end

  describe "#liberate!" do
    subject(:liberate) { instance.liberate! }

    it "does not error" do
      block_is_expected.not_to raise_error
    end

    context "when not unzipping" do
      let(:args) { [
        "-d", dir,
        "-e", "zip,txt",
        "--rename-zip", "bob.zip",
        "-l", " ", # this is a hack to disable FixHtml
        "-t", " ", # this is a hack to disable FixHtml
        "--no-unzip"
      ] }
      let(:extension) { "zip" }

      before do
        UndriveGoogle::Options.instance.define_options(parser)
        parser.parse!(args)
      end

      it "does not open zip" do
        allow(Zip::File).to receive(:open).with(instance.file_path)
        block_is_expected.not_to raise_error
        expect(Zip::File).to_not have_received(:open).with(instance.file_path)
      end
    end

    context "when unzipping" do
      let(:args) { [
        "-d", dir,
        "-e", "zip,txt",
        "--rename-zip", "bob.zip",
        "-l", " ", # this is a hack to disable FixHtml
        "-t", " ", # this is a hack to disable FixHtml
        "-u"
      ] }
      let(:extension) { "zip" }

      before do
        UndriveGoogle::Options.instance.define_options(parser)
        parser.parse!(args)
      end

      it "opens zip" do
        allow(Zip::File).to receive(:open).with(instance.file_path)
        block_is_expected.not_to raise_error
        expect(Zip::File).to have_received(:open).with(instance.file_path)
      end
    end
  end
end

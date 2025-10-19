# frozen_string_literal: true

RSpec.describe UndriveGoogle::Actions::Sweep do
  subject(:instance) { described_class.new }

  let(:parser) { OptionParser.new }
  let(:dir) { "tmp" }
  let(:args) { ["-d", dir] }

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

  describe "#sweep!" do
    subject(:sweep) { instance.sweep! }

    let(:empty_dir) { "spec/fixtures/tmp_empty" }
    let(:full_dir) { "spec/fixtures/tmp_full" }

    it "does not error" do
      block_is_expected.not_to raise_error
    end

    context "when dir is falsey" do
      let(:dir) { "false" }

      it "does not rm" do
        allow(FileUtils).to receive(:rm_rf)
        sweep
        expect(FileUtils).not_to have_received(:rm_rf)
      end
    end

    context "when dir is ' '" do
      let(:dir) { " " }

      it "does not rm" do
        allow(FileUtils).to receive(:rm_rf)
        sweep
        expect(FileUtils).not_to have_received(:rm_rf)
      end
    end

    context "when dir is ' / '" do
      let(:dir) { "  /  " }

      it "does not rm" do
        allow(FileUtils).to receive(:rm_rf)
        sweep
        expect(FileUtils).not_to have_received(:rm_rf)
      end
    end

    context "when dir is non-existent" do
      let(:dir) { "fake-dir" }

      it "does not rm" do
        allow(FileUtils).to receive(:rm_rf)
        sweep
        expect(FileUtils).not_to have_received(:rm_rf)
      end
    end

    context "when dir is empty" do
      let(:dir) { empty_dir }

      before do
        Dir.mkdir(empty_dir) unless Dir.exist?(empty_dir)
        FileUtils.rm_rf Dir.glob("#{empty_dir}/*")
      end

      it "does not rm" do
        allow(FileUtils).to receive(:rm_rf)
        sweep
        expect(FileUtils).not_to have_received(:rm_rf)
      end
    end

    context "when dir is not empty" do
      let(:dir) { full_dir }

      before do
        Dir.mkdir(full_dir) unless Dir.exist?(full_dir)
        FileUtils.touch ["#{full_dir}/a.out", "#{full_dir}/b.out"]
      end

      it "does rm" do
        allow(FileUtils).to receive(:rm_rf)
        sweep
        expect(FileUtils).to have_received(:rm_rf).with(["#{full_dir}/a.out", "#{full_dir}/b.out"])
      end
    end
  end
end

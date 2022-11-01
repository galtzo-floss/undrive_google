# frozen_string_literal: true

RSpec.describe UndriveGoogle::Helpers::Parse do
  it "is a module" do
    expect(described_class).to be_a Module
  end

  describe "::extensions" do
    subject(:extensions) { described_class.extensions(args) }

    let(:args) { "docx" }

    it "does not error" do
      block_is_expected.not_to raise_error
    end

    it "returns an Array" do
      expect(extensions).to be_a(Array)
      expect(extensions).to eq([args])
    end

    context "when all" do
      let(:args) { "all" }

      it "does not error" do
        block_is_expected.not_to raise_error
      end

      it "returns an Array" do
        expect(extensions).to be_a(Array)
        expect(extensions).to eq(UndriveGoogle::DL_FILE_TYPES)
      end
    end

    context "when bad" do
      let(:args) { "bad" }

      it "does error" do
        block_is_expected.to raise_error UndriveGoogle::Error, "Unknown extensions: bad"
      end
    end

    context "when array" do
      let(:args) { %w[txt rtf epub] }

      it "does not error" do
        block_is_expected.not_to raise_error
      end

      it "returns an Array" do
        expect(extensions).to be_a(Array)
        expect(extensions).to eq(args)
      end

      context "when bad" do
        let(:args) { %w[epub txt bad sti] }

        it "does error" do
          block_is_expected.to raise_error UndriveGoogle::Error, "Unknown extensions: [:bad, :sti]"
        end
      end
    end
  end

  describe "::rename_proc" do
    subject(:rename_proc) { described_class.rename_proc(args) }

    let(:args) { [" ", "_"] }

    it "does not error" do
      block_is_expected.not_to raise_error
    end

    it "returns a proc" do
      expect(rename_proc).to be_a(Proc)
    end

    context "when bad" do
      let(:args) { [" "] }

      it "does not error" do
        block_is_expected.to raise_error UndriveGoogle::Error, 'invalid rename pattern [" "]'
      end
    end
  end
end

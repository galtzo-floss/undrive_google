# frozen_string_literal: true

RSpec.describe UndriveGoogle::ConfigFile do
  subject(:instance) { described_class.new(path) }

  let(:path) { UndriveGoogle::CONFIG_YAML_PATH }

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end

    it "has file_id" do
      expect(instance[:file_id]).to eq("1234c4321")
    end

    it "has key_file" do
      expect(instance[:key_file]).to eq("spec/config/serviceid-111111d111111.json")
    end

    it "has dir" do
      expect(instance[:dir]).to eq("tmp")
    end

    it "does not have rename" do
      expect(instance.key?(:rename)).to be(false)
    end

    # Prevent regression where rename_<type> fails to get mapped to hash
    it "does not have rename_txt" do
      expect(instance.key?(:rename_txt)).to be(false)
    end

    context "when no file at path" do
      let(:path) { "such_a_fake_path.yo" }

      it "does not error" do
        block_is_expected.not_to raise_error
      end

      it "does not have file_id" do
        expect(instance.key?(:file_id)).to be(false)
      end

      it "does not have key_file" do
        expect(instance.key?(:key_file)).to be(false)
      end

      it "does not have dir" do
        expect(instance.key?(:dir)).to be(false)
      end

      it "does not have rename" do
        expect(instance.key?(:rename)).to be(false)
      end

      # Prevent regression where rename_<type> fails to get mapped to hash
      it "does not have rename_txt" do
        expect(instance.key?(:rename_txt)).to be(false)
      end
    end

    context "when file with renames at path" do
      let(:path) { "spec/fixtures/renames.yaml" }

      it "does not error" do
        block_is_expected.not_to raise_error
      end

      it "has file_id" do
        expect(instance[:file_id]).to eq("bart")
      end

      it "has key_file" do
        expect(instance[:key_file]).to eq("splatter.json")
      end

      it "has dir" do
        expect(instance[:dir]).to eq("furtive")
      end

      it "has rename[:txt]" do
        expect(instance[:rename][:txt]).to eq("a_txt_file.txt")
      end

      it "has rename[:zip]" do
        expect(instance[:rename][:zip]).to eq("a_zip_file.zip")
      end

      it "has rename_proc" do
        expect(instance[:rename_proc]).to be_a(Proc)
        expect(instance[:rename_proc].call("old_and_busted")).to eq("new_hotness")
      end

      it "has rename[:extensions]" do
        expect(instance[:extensions]).to be_a(Array)
        expect(instance[:extensions]).to eq(%w[docx txt odt epub])
      end

      it "has verbose" do
        expect(instance[:verbose]).to be(true)
      end
    end

    context "when file with unhandled keys at path" do
      let(:path) { "spec/fixtures/unhandled.yaml" }

      it "raises error" do
        block_is_expected.to raise_error UndriveGoogle::Error, "Unhandled config keys [:snark]"
      end
    end
  end

  describe "#any?" do
    subject(:any) { instance.any? }

    it "is true" do
      expect(any).to be(true)
    end

    context "when no file at path" do
      let(:path) { "such_a_fake_path.yo" }

      it "is false" do
        expect(any).to be(false)
      end
    end
  end
end

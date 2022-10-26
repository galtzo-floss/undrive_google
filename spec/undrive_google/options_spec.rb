# frozen_string_literal: true

RSpec.describe UndriveGoogle::Options do
  subject(:instance) { described_class.instance }

  after do
    # Reset to defaults
    instance.send(:initialize)
  end

  describe ".instance" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end

  describe "#define_options" do
    subject(:define_options) { instance.define_options(parser) }

    let(:parser) { OptionParser.new }

    it "does not error" do
      block_is_expected.not_to raise_error
    end

    context "when parsed" do
      subject(:parsed) { parser.parse!(args) }

      before do
        define_options
      end

      context "when help" do
        let(:args) { ["--help"] }

        it "raises SystemExit" do
          block_is_expected.to raise_error SystemExit
        end
      end

      context "when config-yaml" do
        let(:args) { ["--config-yaml", "asdf.yaml"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets config_yaml" do
          block_is_expected.to change(instance, :config_yaml).from("undrive_google.yaml").to("asdf.yaml")
        end
      end

      context "when key-file" do
        let(:args) { ["--key-file", "asdf.json"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets key_file" do
          block_is_expected.to change(instance,
                                      :key_file).from("spec/config/serviceid-111111d111111.json").to("asdf.json")
        end
      end

      context "when file-id" do
        let(:args) { ["--file-id", "4545a6767"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets file_id" do
          block_is_expected.to change(instance, :file_id).from("1234c4321").to("4545a6767")
        end
      end

      context "when file-by" do
        let(:args) { ["--file-by", "title"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets file_by" do
          block_is_expected.to change(instance, :file_by).from(:key).to(:title)
        end
      end

      context "when extensions" do
        let(:args) { ["--extensions", "docx,txt,rtf"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets extensions" do
          block_is_expected.to change(instance,
                                      :extensions).from(%i[docx odt rtf pdf txt zip epub]).to(%w[docx txt rtf])
        end
      end

      context "when --no-unzip" do
        let(:args) { ["--no-unzip"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets unzip" do
          block_is_expected.to change(instance, :unzip).from(true).to(false)
        end
      end

      context "when --no-keep-zip" do
        let(:args) { ["--no-keep-zip"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets keep_zip" do
          block_is_expected.to change(instance, :keep_zip).from(true).to(false)
        end
      end

      context "when --keep-zip" do
        let(:args) { ["--keep-zip"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets keep_zip" do
          block_is_expected.not_to change(instance, :keep_zip).from(true)
        end
      end

      context "when --dir" do
        let(:args) { ["--dir", "my/path"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets dir" do
          block_is_expected.to change(instance, :dir).from("tmp").to("my/path")
        end
      end

      context "when --lang" do
        let(:args) { ["--lang", "es"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets lang" do
          block_is_expected.to change(instance, :lang).from("en").to("es")
        end
      end

      context "when --title" do
        let(:args) { ["--title", "slartibartfarst"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets title" do
          block_is_expected.to change(instance, :title).from(nil).to("slartibartfarst")
        end
      end

      context "when --no-verbose" do
        let(:args) { ["--no-verbose"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets verbose" do
          block_is_expected.not_to change(instance, :verbose).from(false)
        end
      end

      context "when --verbose" do
        let(:args) { ["--verbose"] }

        it "does not error" do
          block_is_expected.not_to raise_error
        end

        it "sets verbose" do
          block_is_expected.to change(instance, :verbose).from(false).to(true)
        end
      end
    end
  end
end

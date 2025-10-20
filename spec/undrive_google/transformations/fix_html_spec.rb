# frozen_string_literal: true

RSpec.describe UndriveGoogle::Transformations::FixHtml do
  subject(:instance) { described_class.new(unzip) }

  let(:html_path) { "some/path.html" }
  let(:unzip) { double(UndriveGoogle::Transformations::Unzip, html_path: html_path) }

  include_context "with google session"

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end

  describe "#process" do
    subject(:process) { instance.process }

    context "with bad path" do
      it "does error" do
        block_is_expected.to raise_error(UndriveGoogle::Error, "No file at #{html_path}")
      end
    end

    context "with good path" do
      # Use the repository-tracked spec/tmp directory (exists on CI) instead of top-level tmp
      let(:html_path) { "spec/tmp/test.html" }
      let(:html) { "<html><head></head><body></body></html>" }

      before do
        File.write(html_path, html)
      end

      after do
        File.delete(html_path) if File.exist?(html_path)
      end

      it "does not error" do
        block_is_expected.not_to raise_error
      end

      context "with default lang" do
        it "updates the html" do
          block_is_expected.to change { File.read(html_path) }.from(html).to("<html lang=\"en\"><head></head><body></body></html>")
        end
      end

      context "with custom options" do
        let(:parser) { OptionParser.new }
        let(:args) { ["-l", lang, "-t", title, "-v"] }
        let(:lang) { "fr" }
        let(:title) { "Bounce to the Ounce" }

        before do
          UndriveGoogle::Options.instance.define_options(parser)
          parser.parse!(args)
        end

        it "updates the html" do
          block_is_expected.to change { File.read(html_path) }.from(html).to("<html lang=\"#{lang}\"><head><title>#{title}</title></head><body></body></html>")
        end

        context "with no lang" do
          let(:args) { ["-l", " ", "-t", title] }

          it "updates the html" do
            block_is_expected.to change { File.read(html_path) }.from(html).to("<html><head><title>Bounce to the Ounce</title></head><body></body></html>")
          end
        end

        context "with nothing" do
          let(:args) { ["-l", " ", "-t", " "] }

          it "does nothing" do
            block_is_expected.not_to change { File.read(html_path) }.from(html)
          end
        end

        context "with no html" do
          let(:html) { "" }

          it "does nothing" do
            block_is_expected.not_to change { File.read(html_path) }.from(html)
          end
        end
      end
    end
  end
end

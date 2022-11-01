# frozen_string_literal: true

RSpec.describe UndriveGoogle::Transformations::RenameHtml do
  subject(:instance) { described_class.new(unzip) }

  let(:dir) { "some" }
  let(:html_path) { "#{dir}/path.html" }
  let(:unzip) { double(UndriveGoogle::Transformations::Unzip, html_path: html_path)}

  include_context "with google session"

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end

  describe "#process" do
    subject(:process) { instance.process }

    let(:parser) { OptionParser.new }
    let(:args) { ["--rename-html", rename_html, "-v"] }
    let(:rename_html) { "posh.html" }

    before do
      UndriveGoogle::Options.instance.define_options(parser)
      parser.parse!(args)
    end

    it "Renames file" do
      allow(File).to receive(:rename).with(html_path, "#{dir}/#{rename_html}")
      process
      expect(File).to have_received(:rename).with(html_path, "#{dir}/#{rename_html}")
    end
  end
end

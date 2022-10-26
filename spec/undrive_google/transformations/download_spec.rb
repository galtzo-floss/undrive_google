# frozen_string_literal: true

RSpec.describe UndriveGoogle::Transformations::Download do
  subject(:instance) { described_class.new("tmp/My_Title.docx", "docx") }

  include_context "with google session"

  let(:options) { {} }

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end
end

# frozen_string_literal: true

RSpec.describe UndriveGoogle::CLI do
  subject(:instance) { described_class.new(options) }

  let(:options) { {} }

  describe "#initialize" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end
end

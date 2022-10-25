# frozen_string_literal: true

RSpec.describe UndriveGoogle::Session do
  subject(:instance) { described_class.instance }

  describe ".instance" do
    it "does not error" do
      block_is_expected.not_to raise_error
    end
  end
end

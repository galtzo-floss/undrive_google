# frozen_string_literal: true

RSpec.shared_context "with google session" do
  let(:double_file) { double("Double File", title: "My Title", export_as_file: nil) }
  let(:drive_session_double) { double("Drive Session", file_by_id: double_file) }
  let(:undrive_session_clone) { UndriveGoogle::Session.clone }
  before do
    allow(UndriveGoogle::Session).to receive(:instance).and_return(undrive_session_clone.instance)
    allow(undrive_session_clone.instance).to receive(:drive_session).and_return(drive_session_double)
  end
end

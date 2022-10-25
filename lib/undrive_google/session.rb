# frozen_string_literal: true

module UndriveGoogle
  # A Google Drive Session
  class Session
    include Singleton

    attr_reader :drive_session

    def initialize
      @drive_session = GoogleDrive::Session.from_service_account_key(Options.instance.key_file)
      raise UndriveGoogle::Error, "no file_id" unless Options.instance.file_id
    end

    def file
      @file ||= drive_session.send(file_by, Options.instance.file_id)
    end

    private

    def file_by
      return :file_by_title if Options.instance.file_by == FILE_BY[:title]

      :file_by_id
    end
  end
end

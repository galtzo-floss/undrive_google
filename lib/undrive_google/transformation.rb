# frozen_string_literal: true

module UndriveGoogle
  Transformation = Struct.new(:download,
                              :unzip,
                              :fix_html,
                              :rename_html,
                              :delete_zip,
                              keyword_init: true) do
    def liberate!
      each(&:process)
    end

    def each
      yield download unless download.nil?
      yield unzip unless unzip.nil?
      yield fix_html unless fix_html.nil?
      # Rename after fix to prevent confusion about the current path of the file
      yield rename_html unless rename_html.nil?
      yield delete_zip unless delete_zip.nil?
    end
  end
end

class Document < ApplicationRecord
  has_one_attached :document_attachment

  def run_executable_file
    tmp_dir = Rails.root.join('tmp')

    temp_file = Tempfile.new(['executable', '.bin'], tmp_dir)
    temp_file.write(self.document_attachment.download)
    temp_file.close

    command_args = self.command_line_args.nil? ? nil : self.command_line_args.split(',').join(' ')
    success = system("#{temp_file.path} #{command_args}")

    temp_file.unlink

    return success
  end
end

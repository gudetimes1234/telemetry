class Document::ExecutableJob
  include Sidekiq::Job

  def perform(document_id, user)
    document = Document.find(document_id)
    process_id = $$
    process_name = $PROGRAM_NAME
    Rails.logger.info "#{Time.now} - #{user.email} -  Document::ExecutableJob: #{process_name} #{process_id}"
    run_executable_file(document)
  end

  def run_executable_file(document)
    tmp_dir = Rails.root.join('tmp')

    temp_file = Tempfile.new(['executable', '.bin'], tmp_dir)
    temp_file.write(document.document_attachment.download)
    temp_file.close

    command_args = document.command_line_args.split(',').join(' ')
    success = system("#{temp_file.path} #{command_args}")

    temp_file.unlink

    if success
      return true
    else
      return false
    end
  end
end

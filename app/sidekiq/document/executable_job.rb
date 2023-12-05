class Document::ExecutableJob
  include Sidekiq::Job

  def perform(document_id, user)
    document = Document.find(document_id)
    process_id = $$
    process_name = $PROGRAM_NAME
    Rails.logger.info "#{Time.now} - #{user.email} -  Document::ExecutableJob: #{process_name} #{process_id}"
    document.run_executable_file
  end
end

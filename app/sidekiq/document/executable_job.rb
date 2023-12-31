class Document::ExecutableJob
  include Sidekiq::Job

  DESTINATION_ADDR = "example.com" # in reality, I'd use an environment variable that would grab this from param store
  DESTINATION_PORT = 8080
  SOURCE_ADDR = "localhost"
  SOURCE_PORT = 1234

  def perform(user)
    documents = Document.where(document_type: ['.sh', '.bin'], completed_at: nil)
    process_id = $$
    process_name = $PROGRAM_NAME
    Rails.logger.info "#{Time.now} - #{user.email} -  Document::ExecutableJob: #{process_name} #{process_id}"
    documents.each do |document|
      begin
        document.run_executable_file
        attached_document = document.document_attachment.download
        tempfile = Tempfile.new
        document.document_attachment.download_blob_to(tempfile)
        number_of_bytes = File.size(tempfile.path)
        tempfile.close
        Document::NetworkJob.new.perform(attached_document, DESTINATION_ADDR, DESTINATION_PORT, SOURCE_ADDR, SOURT_PORT, 'tcp', {email: @user.email}, number_of_bytes)
      rescue StandardError => e
        next
      ensure
        document.update(completed_at: Time.now)
      end
    end
  end
end

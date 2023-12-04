class Document::ExecutableJob
  include Sidekiq::Job

  def perform(document_id, user)
    document = Document.find(document_id)
    Rails.logger.info "#{Time.now} - #{user.email} - "
  end
end

# ○ Timestamp of start time
# ○ Username that started the process
# ○ Process name
# ○ Process command line
# ○ Process ID

class Document::ExecutableJob
  include Sidekiq::Job

  def perform(document_id, user)
    document = Document.find(document_id)
    process_id = $$
    process_name = $PROGRAM_NAME
    Rails.logger.info "#{Time.now} - #{user.email} -  Document::ExecutableJob: #{process_name} #{process_id}"
  end
end

# tmp_dir = Rails.root.join('tmp')
# Dir.mkdir(tmp_dir) unless Dir.exist?(tmp_dir)

# # Create a temporary file to store the downloaded executable
# temp_file = Tempfile.new(['executable', '.bin'], tmp_dir)

# # Download the executable file from Active Storage to the temporary file
# temp_file.write(document.executable.download)
# temp_file.close

# # Run the executable
# result = `#{temp_file.path} arg1 arg2`

# # Alternatively, using system
# success = system("#{temp_file.path} arg1 arg2")

# if success
#   puts "Execution successful"
# else
#   puts "Execution failed"
# end

# # Ensure the temporary file is cleaned up
# temp_file.unlink

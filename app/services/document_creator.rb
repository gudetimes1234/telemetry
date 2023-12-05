class DocumentCreator
  def initialize(user)
    @user = user
  end

  def create(attrs)
    doc = Document.new
    doc.path_to_file = attrs[:path_to_file]
    doc.body = attrs[:body]
    doc.name = attrs[:name]
    doc.user_id = @user.id
    doc.document_type = File.extname(attrs[:name])
    doc.updated_by_id = @user.id
    doc.created_by_id = @user.id
    doc.document_attachment.attach(attrs[:document_attachment])
    doc.save
    log_activity(attrs[:path_to_file], @user.email)
    doc
  end

  private

  def log_activity(path_to_file, email)
    process_id = $$
    process_name = $PROGRAM_NAME
    logger = Logger.new('document_creator.log')
    logger.info("#{Time.now} - #{path_to_file}, created by #{email}, DocumentCreator: #{process_name} #{process_id}")
  end
end

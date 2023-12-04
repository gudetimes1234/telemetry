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
    doc.updated_by_id = @user.id
    doc.created_by_id = @user.id
    doc.document_attachment.attach(attrs[:document_attachment])
    doc.save
    doc
    process_id = $$
    process_name = $PROGRAM_NAME
    Rails.logger.info "#{Time.now} - #{attrs[:path_to_file]}, created by #{@user.email}, DocumentCreator: #{process_name} #{process_id}"
  end
end

class DocumentDestroyer
  def initialize(user)
    @user = user
  end

  def destroy(id)
    doc = Document.find_by(id: id)
    doc.document_attachment.purge
    doc.destroy!
    process_id = $$
    process_name = $PROGRAM_NAME
    Rails.logger.info "#{Time.now} - #{doc.path_to_file}, deleted by #{@user.email}, DocumentDestroyer: #{process_name} #{process_id}"
  end
end

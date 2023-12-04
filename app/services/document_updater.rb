class DocumentUpdater
  def initialize(user)
    @user = user
  end

  def update(attrs)
    doc = Document.find_by(id: attrs[:id])
    attached_file = doc.document_attachment.download
    tempfile = Tempfile.new('document')
    tempfile.write(attrs[:body])
    tempfile.rewind
    doc.document_attachment.attach(io: tempfile, filename: doc.name, content_type: 'text/plain')
    doc.save
    tempfile.close
    tempfile.unlink
    process_id = $$
    process_name = $PROGRAM_NAME
    Rails.logger.info "#{Time.now} - #{attrs[:path_to_file]}, updated by #{@user.email}, DocumentUpdater: #{process_name} #{process_id}"
    doc
  end
end

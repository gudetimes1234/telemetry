require 'rails_helper'

RSpec.describe DocumentUpdater do
  user = User.create!(email: 'charles@gmail.com', password: 'dogs make good pets!')

  it 'updates a documents body' do
    file_path = Rails.root.join('files', 'sample.txt')
    uploaded_file = Rack::Test::UploadedFile.new(file_path, 'text/plain')
    attrs = {
      path_to_file: 'heres/the/file',
      body: 'here is some text',
      name: 'example.txt',
      document_attachment: uploaded_file
    }
    DocumentCreator.new(user).create(attrs)
    old_document_body = Document.first.document_attachment.download
    attrs = {
      id: Document.first.id,
      body: 'this is the new body'
    }
    DocumentUpdater.new(user).update(attrs)
    document = Document.first
    expect(document.document_attachment.download).to eq 'this is the new body'
  end
end

require 'rails_helper'

RSpec.describe DocumentCreator do
  user = User.create!(email: "charles-#{SecureRandom.uuid}@gmail.com", password: 'dogs make good pets!')

  it 'creates an active storage file' do
    file_path = Rails.root.join('files', 'sample.txt')
    uploaded_file = Rack::Test::UploadedFile.new(file_path, 'text/plain')
    attrs = {
      path_to_file: 'heres/the/file',
      name: 'example.txt',
      document_attachment: uploaded_file
    }
    DocumentCreator.new(user).create(attrs)

    document = Document.first
    expect(document.document_attachment).not_to be_nil
    expect(document.document_attachment.download).to eq 'there is some text here'
  end
end

require 'rails_helper'

RSpec.describe DocumentDestroyer do
  user = User.create!(email: "charles-#{SecureRandom.uuid}@gmail.com", password: 'dogs make good pets!')

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

    doc = Document.first
    DocumentDestroyer.new(user).destroy(doc.id)
    expect(Document.count).to eq 0
  end
end

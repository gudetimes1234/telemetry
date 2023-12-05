require 'rails_helper'

RSpec.describe Document, type: :model do
  user = User.create!(email: "charles-#{SecureRandom.uuid}@gmail.com", password: 'dogs make good pets!')

  it 'can have an executable file work' do
    file_path = Rails.root.join('files', 'executable.sh')
    uploaded_file = Rack::Test::UploadedFile.new(file_path, 'text/plain')
    attrs = {
      path_to_file: 'heres/the/file',
      body: 'echo hello $1',
      name: 'example.sh',
      command_line_args: 'charles,thiswontgetused'
    }
    DocumentCreator.new(user).create(attrs)
    val = Document::ExecutableJob.perform_async(attrs, user)
    expect(val).to_not be_nil
    expect(val).to be_truthy
  end

  it 'cant have failing executable files run on it' do
    file_path = Rails.root.join('files', 'bad_executable.sh')
    uploaded_file = Rack::Test::UploadedFile.new(file_path, 'text/plain')
    attrs = {
      path_to_file: 'heres/the/file',
      body: '-1',
      name: 'example.sh',
      command_line_args: ''
    }
    DocumentCreator.new(user).create(attrs)
    doc = Document.first
    val = doc.run_executable_file
    expect(val).to be_nil
    expect(val).to be_falsey
  end


end

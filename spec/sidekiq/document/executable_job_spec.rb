require 'rails_helper'
RSpec.describe Document::ExecutableJob, type: :job do
  user = User.create!(email: 'charles@gmail.com', password: 'dogs make good pets!')
  # Document.create(user_id: user.id, created_by_id: user.id, updated_by_id: user.id)

  it 'creates an active storage file' do
    attrs = {
      path_to_file: 'heres/the/file',
      body: 'echo hello $1',
      name: 'example.sh'
    }
    Document::ExecutableJob.perform_async(attrs, user)
    expect(Document.count).to eq 1
  end
end

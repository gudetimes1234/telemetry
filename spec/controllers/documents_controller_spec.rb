require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  it 'should get index' do
    get :index
    expect(response.status).to eq 200
  end

  describe 'POST create' do
    user = User.create!(email: "charles-#{SecureRandom.uuid}@gmail.com", password: 'dogs make good pets!')

    it 'should create a document' do
      user = User.create!(email: "charles-#{SecureRandom.uuid}@gmail.com", password: 'dogs make good pets!')
      sign_in user
      post :create, params: { document: { user_id: user.id, name: 'sample.txt', body: 'here is some text', path_to_file: '/heres/the/file' } }
      expect(response.status).to eq 201
    end
  end
end

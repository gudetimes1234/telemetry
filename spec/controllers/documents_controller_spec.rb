require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  before do
    user = User.create!(email: "charles-#{SecureRandom.uuid}@gmail.com", password: 'dogs make good pets!')
    Document.create(user_id: user.id, created_by_id: user.id, updated_by_id: user.id)
  end

  it 'should get index' do
    get :index
    expect(response.status).to eq 200
  end

  # describe 'POST create' do
  #   it 'should create a document' do
  #     user = User.first
  #     post :create, params: { document: { user_id: user.id } }
  #     expect(response.status).to eq 201
  #   end
  # end
end

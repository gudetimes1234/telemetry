class DocumentsControllerTest < ActionDispatch::IntegrationTest
  before do
    user = User.create!(email: 'cgude@gmail.com', password: 'dogs make good pets!')
    Document.create(user_id: user.id, created_by_id: user.id, updated_by_id: user.id)
  end

  test 'should get index' do
    get documents
    assert_response :success
  end
end

class HomeController < ApplicationController
  def index
    render({ json: { message: 'Welcome to the Document Management System' }, status: 200 })
  end
end

class DocumentsController < ApplicationController
  def index
    documents = Document.all
    render({ json: documents, status: 200 })
  end

  def show
    document = Document.find_by(params[:id])
    render({ json: document, status: 200 })
  end

  def create
    document = DocumentCreator.new(current_user).create(document_params)
    render({ json: document, status: 201 })
  end

  def update
    document = Document.find_by(params[:id])
    document = DocumentUpdater.new(current_user).update(update_params)
    render({ json: document, status: 200 })
  end

  def destroy
    DocumentDestroyer.new(current_user).destroy(params[:id])
    render({ status: 204 })
  end

  private

  def document_params
    params.require(:document).permit(:document_attachment, :name, :path_to_file, :body, :user_id)
  end

  def update_params
    params.require(:document_attachment).permit(:body)
  end
end

class AddBodyToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :body, :text
  end
end

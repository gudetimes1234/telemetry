class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :user, type: :integer, index: true, null: false
      t.string :name
      t.string :path_to_file
      t.string :document_type
      t.integer :created_by_id, null: false
      t.integer :updated_by_id, null: false
      t.timestamps null: false
    end
  end
end

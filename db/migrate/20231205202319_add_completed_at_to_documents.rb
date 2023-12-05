class AddCompletedAtToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :completed_at, :datetime
  end
end

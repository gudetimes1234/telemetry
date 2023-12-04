class AddCommandLineArgumentsToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :command_line_args, :text
  end
end

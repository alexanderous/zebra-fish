class AddNoteToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :note, :text
  end
end

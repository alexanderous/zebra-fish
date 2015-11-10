class AddPhoneToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :phone, :string
  end
end

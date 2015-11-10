class AddTopicToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :topic, :text
  end
end

# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :text
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  draft      :boolean
#  user_id    :integer
#  image      :string(255)
#

class Article < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :draft, :created_at, :image
  belongs_to :user

  mount_uploader :image, ImageUploader
  process_in_background :image
end

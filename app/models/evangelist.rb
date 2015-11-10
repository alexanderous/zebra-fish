# == Schema Information
#
# Table name: evangelists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string(255)
#  note       :text
#

class Evangelist < ActiveRecord::Base
  attr_accessible :email, :name, :note, :phone

  before_save { |evangelist| evangelist.email = evangelist.email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  #validates :phone, :numericality => true, :length => { :minimum => 7, :maximum => 15 }


  default_scope order: 'evangelists.created_at DESC'
end

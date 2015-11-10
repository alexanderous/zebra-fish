# == Schema Information
#
# Table name: loves
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  loved_id   :integer
#  lover_id   :integer
#

class Love < ActiveRecord::Base
  attr_accessible :lover_id, :loved_id

  belongs_to :lover, class_name: "User"
  belongs_to :loved, class_name: "Micropost"

  validates :lover_id, :presence => true #user
  validates :loved_id, :presence => true #micropost
  validates_uniqueness_of :loved_id, scope: :lover_id

end

# == Schema Information
#
# Table name: microposts
#
#  id          :integer          not null, primary key
#  content     :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  image       :string(255)
#  dateofevent :datetime
#  subject_id  :integer
#  hide        :boolean
#  title       :string(255)
#  draft       :boolean
#  topic       :text
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :image, :subject_id, :dateofevent, :hide, :title, :remove_image, :subject_name, :draft, :created_at, :topic
  belongs_to :user
  belongs_to :subject, :class_name => "User"
  belongs_to :lover, :class_name => "User"
  has_many :comments, :dependent => :destroy
  has_many :loves, foreign_key: "loved_id"
  has_many :lovers, through: :loves
  
  mount_uploader :image, ImageUploader
  process_in_background :image

  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'

  def bids
    read_attribute(:bids) || loves.sum(:value)
  end
    
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def subject_name
    subject.try(:name)
  end

  def subject_name=(name)
    self.subject = User.find_by_name(name) if name.present?
  end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  image                  :string(255)
#  invited_at             :datetime
#  accepted_at            :datetime
#  invitation_id          :integer
#  invitation_limit       :integer
#  state                  :string(255)
#  active                 :boolean
#  invite_token           :string(255)
#  invite_sent_at         :datetime
#  initiate_token         :string(255)
#  dead                   :boolean
#  admin_id               :integer
#  login                  :string(255)
#  birth_year             :date
#  death_year             :date
#  message                :text
#  contributor_id         :integer
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :image, :active, :admin_id, :dead, :login, :death_year, :birth_year, :remove_image, :message, :contributor_id
  has_secure_password

  has_many :microposts
  has_many :articles
  #has_many :friends
  has_many :comments, :dependent => :destroy
  has_many :loves, foreign_key: "lover_id", :dependent => :destroy
  #has_many :legacy_anthologies, :class_name => "User", :foreign_key => "admin_id"
  #belongs_to :admin, :class_name => "User"
  has_one :contributor, :class_name => "User"
  has_many :loved_microposts, through: :loves, source: :loved

  include Amistad::FriendModel

  before_validation :create_temp_password
  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  #validates :message, presence: true 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :login, presence: true, uniqueness: { case_sensitive: false }, :on => :update                 
  validates :password, length: { minimum: 6 }, :on => :create 
  validates :password_confirmation, presence: true, :on => :create

  default_scope order: 'users.name ASC'
  mount_uploader :image, ImageUploader
  process_in_background :image


  def self.search(search, page)
      paginate :per_page => 16, :page => page,
                :conditions => ['name ILIKE ?', "%#{search}%"], :order => 'name'
  end

  def can_love?(micropost)
    loves.build(value: 1, micropost: micropost).valid?
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def send_notify(micropost_id)
    save!(validate: false)
    UserMailer.notify(micropost_id).deliver 
  end

  def send_comment_author_notify(comment_id)
    save!(validate: false)
    UserMailer.comment_author_notify(comment_id).deliver
  end

  def send_comment_subject_notify(comment_id)
    save!(validate: false)
    UserMailer.comment_subject_notify(comment_id).deliver
  end

  def send_email_verification #not in use right now; we skipped this step since it's invite-only
    generate_token(:invite_token)
    self.invite_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.email_verification(self).deliver
  end

  def send_invite 
    generate_token(:invite_token)
    self.invite_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.invite(self).deliver
  end

  def send_signup_confirmation
    UserMailer.signup_confirmation(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def show_posts
     #Micropost.where(:subject_id => @user.id).reorder('dateofevent') #this orders posts differently
  end  

  def other_user_index
  end

  def feed
    #Micropost.where(["created_at in (?) or "])
    Micropost.where(["user_id in (?) or subject_id in (?) or user_id in (?) or subject_id in (?)", self.friends, self.friends, self, self])
    #this was the formula for the original feed at antho.co
  end


  def anthology
    Micropost.where("subject_id = ? or user_id = ?", self.id, self.id)#.reorder('dateofevent')
    #Micropost.where("user_id = (?)", @user.id)
    
  end
  

  

  def loving?(micropost)
    loves.find_by_loved_id(micropost.id)
  end

  def love!(micropost)
    loves.create!(loved_id: micropost.id)
  end

  def unlove!(micropost)
    loves.find_by_loved_id(micropost).destroy
  end

  private

    def create_temp_password
      self.initiate_token = SecureRandom.urlsafe_base64(20)
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

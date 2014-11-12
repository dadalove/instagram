class Photo < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :comments, :dependent => :destroy
  has_many :commented_users, :through => :comments, :source => :user

  validates_presence_of :content
  validates_presence_of :avatar_file_name

  belongs_to :user
  has_many :likes
  has_many :subscriptions

end

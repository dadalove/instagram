class Photo < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :comments, :dependent => :destroy
  has_many :commented_users, :through => :comments, :source => :user

  has_many :tagships
  has_many :tags, :through => :tagships

  validates_presence_of :content
  validates_presence_of :avatar_file_name

  belongs_to :user
  has_many :likes
  has_many :subscriptions

  def find_like_by_user(user)
    self.likes.where( :user => user ).first
  end

  def can_user_like?(user)
    find_like_by_user(user).nil?
  end

  def find_subscription_by_user(user)
    self.subscriptions.where( :user => user ).first
  end

  def can_user_subscription?(user)
    find_subscription_by_user(user).nil?
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
 
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).photos
  end
end

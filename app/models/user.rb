class User < ActiveRecord::Base

  has_many :friendships
  has_many :friends, ->{ where( "friendships.status" => "confirmed") }, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, ->{ where( "friendships.status" => "confirmed") }, :through => :inverse_friendships, :source => "user"

  has_many :comments, :dependent => :destroy
  has_many :photos, :through => :comments

  has_many :photos

  has_many :likes
  has_many :subscriptions

  def self.from_omniauth(auth_hash)
    user = where( :fb_uid => auth_hash[:uid] ).first_or_initialize
    user.name = auth_hash[:info][:name]
    user.email = auth_hash[:info][:email]
    user.fb_token = auth_hash[:credentials][:token]
    user.fb_expires_at = Time.at(auth_hash[:credentials][:expires_at])
    user.save!
    user
  end

end

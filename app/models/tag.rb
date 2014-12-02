class Tag < ActiveRecord::Base

  has_many :tagships, :dependent => :destroy
  has_many :photos, :through => :tagships

  def self.counts
    self.select("name, count(tagships.tag_id) as count").joins(:tagships).group("tagships.tag_id")
  end
end

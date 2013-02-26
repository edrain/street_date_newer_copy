# == Schema Information
#
# Table name: list_items
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ListItem < ActiveRecord::Base
  attr_accessible :user_id, :artist_id, :artist_image, :artist_name, :artist_url, :artist_albums
  attr_accessor :artist_image, :artist_name, :artist_url, :artist_albums
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :artist_id, presence: true

  def add_artist_image(image)
    self.artist_image = image
  end
  
  def add_artist_name(name)
    self.artist_name = name
  end

  def add_artist_url(url)
    self.artist_url = url
  end

  def add_artist_albums(albums)
    self.artist_albums = albums
  end
end




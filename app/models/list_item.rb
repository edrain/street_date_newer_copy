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
  attr_accessible :user_id, :artist_id
  belongs_to :user
  
  validates :user_id, presence: true
  validates :artist_id, presence: true
  
end

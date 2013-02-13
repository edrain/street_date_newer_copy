class ReleasesController < ApplicationController
  def show
    @list_items = ListItem.select("DISTINCT artist_id").where("id IS NOT NULL")
    
    #adjust this, obviously
  	@today = Date.today-1   #.to_s
        
    artists = []
       
    @list_items.each do |list_item|
    	@release = ITunesSearch.lookup_artist_most_recent(:id => list_item.artist_id, :entity => "album", :limit => "1", :sort => "recent").to_date
      
    	if @release == @today
    	  #@test = "Yes"    	  
        artists << list_item.artist_id
    	end      	  
    end
  
    @artists = artists
  
  end  
end
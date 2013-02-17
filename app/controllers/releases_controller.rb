class ReleasesController < ApplicationController
  def show
    #Get all artists from DB
    @list_items = ListItem.select("DISTINCT artist_id") #.where("id IS NOT NULL")
    
#adjust this, obviously
  	@today = Date.today-4   #.to_s

    #Get most recent release for each artist       
    @list_items.each do |list_item|
    	result = ITunesSearch.lookup_artist_most_recent(
    	      :id => list_item.artist_id, 
    	      :entity => "album", 
    	      :limit => "1", 
    	      :sort => "recent"
    	      ) 
          	
    	list_item["release_date"] = result["releaseDate"].to_date
    	#artist_name doesn't work here for some reason.
      list_item["artist"] = result["artistName"]
    	list_item["album_name"] = result["collectionName"]
    	list_item["album_image"] = result["artworkUrl100"]
    	list_item["web_url"] = result["collectionViewUrl"]
    	list_item["itunes_url"] = result["collectionViewUrl"].sub('https','itms')
    end

    #Add new releases to artists array if they have releases today
    @releases = @list_items.select { |list_item| @today == list_item["release_date"] }

    #create array of artist_ids to use to query users table
    #this could probably be handled better / more efficiently
    artists = []

    @releases.each do |release|
  	  if release["release_date"] == @today
        artists << release.artist_id
  	  end      	  
    end

    #Get all relevant artist / user combos    
    @users = User.find(:all, 
            :joins => [:list_items], 
            :select => "distinct users.id, users.email, users.user_name, list_items.artist_id",
            :conditions => {:list_items => {:artist_id => artists}},
            :order => "users.id"
            )
            
    #Merge releases and users        
    @users.each do |user|
      @releases.each do |release|
        if user.artist_id == release.artist_id
          user["artist_name"] = release.artist
          user["album_name"] = release.album_name
          user["album_image"] = release.album_image
        	user["web_url"] = release.web_url
        	user["itunes_url"] = release.itunes_url
        end
      end
    end   
               
  end  
end
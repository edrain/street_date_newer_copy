class ReleasesController < ApplicationController
  def show
    @list_items = ListItem.select("DISTINCT artist_id") #.where("id IS NOT NULL")
    
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
    
    @artist_users = ListItem.where(:artist_id => @artists)
    #@orders = Order.where(:customer_id => @customer.id)
    #@users = artists    
    #@users = ListItem.users
    
    @users = User.find(:all, 
            :joins => [:list_items], 
            :select => "distinct users.id, users.email, list_items.artist_id",
            :conditions => {:list_items => {:artist_id => @artists}})
            
#    foo = a.find(:all, 
#           :joins => [:b, :c], 
#           :select => "distinct b.b2 as b2_value, c.c2 as c2_value", 
#           :conditions => {:a => {:a1 => Time.now.midnight. ... Time.now}}, 
#           :group => "b.b2, c.c2")
  
  end  
end
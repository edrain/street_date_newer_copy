class StaticPagesController < ApplicationController
  def home
    @term = params[:term]
    @search = ITunesSearch.search(:term => @term, :country => "US", :media => "music", :entity => "musicArtist", :attribute => "artistTerm", :limit => "10")
    
    if user_signed_in?
      @list_items = ListItem.where( :user_id => current_user.id)
    else 
      @list_items = nil
    end
    
    @search.each do |artist|
      @image = ITunesSearch.lookup_artist_image(:id => artist["artistId"], :entity => "album")
      artist["artistImage"] = @image
      
      @albums = ITunesSearch.lookup_artist_albums(:id => artist["artistId"], :entity => "album")
      artist["artistAlbums"] = @albums
            
      artist["artistInList"] = "0"       
      if @list_items != nil
        @list_items.each do |list_item|
          if list_item.artist_id == artist["artistId"]
            artist["artistInList"] = "1"       
          end
        end
      end
    end
    @search.delete_if {|hash| hash["artistImage"] == nil}
    
    session["user_return_to"] = request.fullpath
    
  end
  
  def help
  end

  def about
  end

  def contact
  end

end

class ListItemsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def show
    @list_owner = User.find(params[:id])
    
    @list_shareable = @list_owner.shareable
    
    @list_editable = false

    if user_signed_in?
      if @list_owner.id == current_user.id
        @list_editable = true
      else
        @list_editable = false
      end
    else
      @list_editable = false  
    end
    
    if @list_shareable == true or @list_editable == true
      @display_list = true
      #@list_items = ListItem.where(params[:user_id]).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
      #Post.where(:published => true).paginate(:page => params[:page]).order('id DESC')
      @list_items = ListItem.where(:user_id => params[:id]).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
      
      @list_items.each do |artist|
        @image = ITunesSearch.lookup_artist_image(:id => artist["artist_id"], :entity => "album", :limit => "1", :sort => "recent")
        @albums = ITunesSearch.lookup_artist_albums(:id => artist["artist_id"], :entity => "album")
        @artist_info = ITunesSearch.lookup(:id => artist["artist_id"], :entity => "album")
        artist.add_artist_image(@image)
        artist.add_artist_name(@artist_info["artistName"]) 
        artist.add_artist_url(@artist_info["artistLinkUrl"])                
        artist.add_artist_albums(@albums)                
      end  
    else
      @display_list = false
    end

    session["user_return_to"] = request.fullpath          

  end

  def create
    @list_item = ListItem.new( :user_id => current_user.id, :artist_id => params[:artist_id] )

    @return_to = request.referer

    @artist_id = params[:artist_id]

    if @list_item.save
      respond_to do |format|
        format.html { redirect_to @return_to }
        format.js
      end
    else
      redirect_to @return_to
    end
  end
  
  def destroy
    ListItem.find( params[:id] ).destroy
      
    @id = params[:id]  
      
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end    
  end

end
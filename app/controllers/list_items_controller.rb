class ListItemsController < ApplicationController
  before_filter :authenticate_user!

  def show
    #@list_items = ListItem.find(params[:user_id])
  end


  def create
    @list_item = ListItem.new( :user_id => current_user.id, :artist_id => params[:artist_id] )

    if @list_item.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
  
  def destroy
  end

end
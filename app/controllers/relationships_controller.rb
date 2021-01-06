class RelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:id])
    current_user.follow(params[:id])
    redirect_to request.referrer
  end
  
  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(params[:id])
    redirect_to request.referrer
  end
end

class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    idea = Idea.find(params[:idea_id])
    like = Like.new(idea: idea, user: current_user)
    if like.save && ( idea.user != current_user )
      redirect_to idea, flash: { info: "Liked" }
    else
      redirect_to idea, flash: { info: "Already Liked"}
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy
    redirect_to idea_path(params[:idea_id]), flash: { info: "Unliked"}
  end

end

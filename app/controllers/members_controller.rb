class MembersController < ApplicationController
  before_action :authenticate_user

  def create
    idea = Idea.find(params[:idea_id])
    member = Member.new(idea: idea, user: current_user)
    if member.save
      redirect_to idea, flash: { success: "Liked" }
    else
    redirect_to idea, flash: { info: "Already Liked"}
    end
  end

  def destroy
    member = current_user.members.find(params[:id])
    member.destroy
    redirect_to idea_path(params[:idea_id]), flash: { warning: "Unliked"}
  end

end

class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]
  before_action :authenticate_user
  before_action :authorize_user, only: [:destroy]

  def create
    @idea = Idea.find(params[:idea_id])
    @comment = Comment.new(comment_params)
    @comment.idea = @idea
    @comment.user = current_user
    if @comment.save
      redirect_to idea_path(@idea), flash: { success:  "Comment created" }
    else
      flash[:warning] = 'Comment Not Created'
      render "ideas/show"
    end
  end

  def edit
  end

  def update
    idea = Comment.find(params[:id]).idea_id
    if @comment.update(comment_params)
      redirect_to idea_path(idea), flash: { success: "Comment updated..."}
    else
      render :edit
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy
    redirect_to idea_path(params[:idea_id]), flash: {danger: "Comment Deleted" }
  end

    private

      def find_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit([:body])
      end

      def authorize_user
        unless ((can? :manage, @comment) || (can? :destroy, @comment))
          redirect_to root_path , flash: { info: "Access Denied" }
        end
      end

end

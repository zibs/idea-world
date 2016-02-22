class IdeasController < ApplicationController

  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.order("created_at DESC") #.page(params[:page]).per(15)
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user
    if @idea.save
      flash[:success] = "idea added"
      redirect_to idea_path(@idea)
    else
      flash[:warning] = "idea unsuccessfully added"
      render :new
    end
  end

  def show
    # @task = Task.new
    # @discussion = Discussion.new
    # @tasks = @idea.tasks.order("created_at DESC")
    # display complete/incomplete tasks
    # @tasks_done = @idea.tasks.where(["done = ?", true]).order("created_at DESC")
    # @tasks_not_done = @idea.tasks.where(["done = ?", false]).order("created_at DESC")
    # @discussions = @idea.discussions.order("created_at DESC")
  end

  def edit
  end

  def update
    if @idea.update(idea_params)
      redirect_to(idea_path(@idea), flash: { success:  "idea Updated"})
    else
      flash[:warning] = "Update was not successful"
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to((root_path), flash: { danger: "idea Removed!" })
  end


      private

        def idea_params
          params.require(:idea).permit([:title, :body])
        end

        def find_idea
          @idea = Idea.find(params[:id])
        end

        def authorize_user
          unless can? :manage, @idea
          redirect_to root_path , flash: { info: "Access Denied" }
          end
        end

end

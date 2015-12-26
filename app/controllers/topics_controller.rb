class TopicsController < ApplicationController

  def index
    @topics = Topic.paginate(page: params[:page])
    authorize @topics
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page])
    authorize @topic
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic

    if @topic.save
      flash[:notice] = "Topic saved."
      redirect_to @topic
    else
      flash[:danger] = "There was a problem saving your topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic

    if @topic.update(topic_params)
      flash[:notice] = "Topic updated."
      redirect_to @topic
    else
      flash[:danger] = "There was a problem saving your topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic

    if @topic.destroy
      flash[:notice] = "Topic deleted"
      redirect_to @topics
    else
      flash[:danger] = "There was a problem deleting your topic. Please try again."
      redirect_to @topic
    end
  end

  private

    def topic_params
      params.require(:topic).permit(:public, :name, :description)
    end
end

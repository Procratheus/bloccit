class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:notice] = "Question saved!"
      redirect_to @question
    else
      flash[:error] = "There was a problem saving your question! Please try again."
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      flash[:notice] = "Question updated!"
      redirect_to @question
    else
      flash[:error] = "There was a problem updating your question! Please try again."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      flash[:notice] = "Question deleted!"
      redirect_to @questions
    else
      flash[:error] = "There was a problem deleting your question! Please try again."
      render @question
    end
  end

  private

    def question_params
      params.require(:question).permit(:title, :body, :resolved)
    end
end

class SubjectsController < ApplicationController
  respond_to :json

  def index
    respond_with Subject.all
  end

  def show
    respond_with Subject.find(params[:id])
  end
end

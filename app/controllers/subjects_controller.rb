class SubjectsController < ApplicationController
  respond_to :json

  def index
    respond_with Subject.all
  end
end

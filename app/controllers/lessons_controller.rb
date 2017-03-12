class LessonsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lessons_by_categories = current_user.lessons_by_categories
  end
end

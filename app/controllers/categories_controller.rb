class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.search(params[:search])
  end

  def show
    @category = Category.find_by(id: params[:id])
    return redirect_to categories_path, alert: "Category doesn't exist" if !@category
    @users = @category.authors.uniq
  end
end

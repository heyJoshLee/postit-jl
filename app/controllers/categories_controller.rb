class CategoriesController < ApplicationController

  before_action :set_new_category, only: [:new]
  before_action :require_user, only: [:new, :create]

  def new
  end

  def create

    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "New category was created"
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def show 
    @category = Category.find(params[:id ])
  end


  def category_params
    params.require(:category).permit!
  end

  def set_new_category
    @category = Category.new
  end

end
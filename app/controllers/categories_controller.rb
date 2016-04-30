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

    @page = params[:page] || 1
    @limit = 2
    offset = @page.to_i > 1 ? @limit * (@page.to_i - 1) : 0
    @posts = @category.posts.order(created_at: :desc).limit(@limit).offset(offset)

  end


  def category_params
    params.require(:category).permit!
  end

  def set_new_category
    @category = Category.new
  end

end
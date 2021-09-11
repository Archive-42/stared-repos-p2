class CatsController < ApplicationController
  def index 
    @cats = Cat.all 
    render :index 
  end

  def show 
    @cat = Cat.includes(:rental_requests).order('cat_rental_requests.start_date').find_by(id: params[:id])
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_url
    else 
      render :new 
    end
  end

  def new 
    @cat = Cat.new
    render :new
  end

  def edit 
    @cat = Cat.find_by(id: params[:id])
    render :edit 
  end

  def update

    @cat = Cat.find_by(id: params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cats_url
    else
      render :edit 
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end
end
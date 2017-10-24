class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    if @cat
      render :show
    else
      render json: @cat.errors.full_messages, status: 404
    end
  end


  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to "/cats/#{@cat.id}"
    else
      render json: @cat.errors.full_messages, status: 422
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to "/cats/#{@cat.id}"
    else
      render json: @cat.errors.full_messages, status: 404
    end
  end


  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color,
                                :sex, :description)
  end
end

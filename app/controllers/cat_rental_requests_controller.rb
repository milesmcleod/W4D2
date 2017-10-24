class CatRentalRequestsController < ApplicationController

  def index
    @rentals = CatRentalRequest.all.order(:start_date)
    render :index
  end

  def new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(rental_params)
    @cat_rental_request.status = 'PENDING'
    if @cat_rental_request.save
      redirect_to "/cat_rental_requests"
    else
      render json: @cat_rental_request.errors.full_messages, status: 422
    end
  end

  private

  def rental_params
    params.require(:cat_rental_request).permit(:cat_id,:start_date,:end_date)
  end

end

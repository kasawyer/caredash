class ReviewsController < ApplicationController
  # GET /doctors/1/reviews
  def index
    @doctor = Doctor.find(params[:doctor_id])
    @reviews = @doctor.reviews
    render json: @reviews.as_json(include: [:doctor])
  end

  # GET /doctors/1/reviews/1
  def show
    @doctor = Doctor.find(params[:doctor_id])
    @review = @doctor.reviews.find(params[:id])
    render json: @review.as_json(include: [:doctor])
  end

  # GET /doctors/1/reviews/new
  def new
    @doctor = Doctor.find(params[:doctor_id])
    @review = Review.new
  end

  # POST /doctors/1/reviews
  def create
    @doctor = Doctor.find(params[:doctor_id])
    @review = Review.new(review_params)
    @review.doctor = @doctor

    if @review.save
      flash[:notice] = "Review saved successfully."
      redirect_to doctor_path(@doctor)
    else
      flash.now[:notice] = "Failed to save review."
      render :new
    end
  end

  # GET /doctors/1/reviews/1/edit
  def edit
    @doctor = Doctor.find(params[:doctor_id])
    @review = @doctor.reviews.find(params[:id])
  end

  # PUT/PATCH /doctors/1/reviews/1
  def update
    @doctor = Doctor.find(params[:doctor_id])
    @review = @doctor.reviews.find(params[:id])

    if @review.update(review_params)
      flash[:notice] = ["Review updated successfully."]
      redirect_to @review
    else
      flash.now[:notice] = @review.errors.full_messages
      render :edit
    end
  end

  # DELETE /doctors/1/reviews/1
  def destroy
    @doctor = Doctor.find(params[:doctor_id])
    @review = @doctor.reviews.find(params[:id])
    @review.destroy
    flash[:notice] = ["Review was successfully deleted."]
    redirect_to doctor_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:doctor_id, :description)
  end
end

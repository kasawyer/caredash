class DoctorsController < ApplicationController

  # GET /doctors
  def index
    @doctors = Doctor.all
    render json: @doctors.as_json(include: [:reviews])
  end

  # GET /doctors/1
  def show
    @doctor = Doctor.find(params[:id])
    render json: @doctor.as_json(include: [:reviews])
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
    @notice = flash[:notice]
  end

  # POST /doctors
  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      flash[:notice] = ["Doctor was successfully created."]
      redirect_to @doctor
    else
      flash.now[:notice] = @doctor.errors.full_messages
      render :new
    end
  end

  # GET /doctors/1/edit
  def edit
    @doctor = Doctor.find(params[:id])
  end

  # PUT/PATCH /doctors/1
  def update
    @doctor = Doctor.find(params[:id])

    if @doctor.update(doctor_params)
      flash[:notice] = ["Doctor updated successfully."]
      redirect_to @doctor
    else
      flash.now[:notice] = @doctor.errors.full_messages
      render :edit
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.reviews.each do |review|
      review.destroy
    end
    @doctor.destroy
    flash[:notice] = ["Doctor was successfully deleted."]
    redirect_to doctors_path
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name)
  end
end

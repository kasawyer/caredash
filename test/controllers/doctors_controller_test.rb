# require "rails_helper"
#
# RSpec.describe DoctorsController, type: :controller do
#   let!(:doctor) do
#     FactoryGirl.create(:doctor)
#   end
#
#   let!(:doctor_2) do
#     FactoryGirl.create(:doctor, name: "Doctor Jones")
#   end
#
#   describe "GET #index" do
#     it "should return a list of doctors" do
#       get :index
#       json = JSON.parse(response.body)
#       expect(json.length).to eq(2)
#       expect(json[0]["name"]).to eq("Doctor Sawyer")
#       expect(json[1]["name"]).to eq("Doctor Jones")
#     end
#   end
#
#   describe "GET #show" do
#     it "should return the page for a specific doctor" do
#       get :show, params: { id: doctor.id }
#       json = JSON.parse(response.body)
#       expect(json[0]["name"]).to eq("Doctor Sawyer")
#       expect(json[1]["name"]).to eq("Doctor Jones")
#     end
#   end
#
#   describe "DELETE #destroy" do
#     it "should delete the doctor" do
#       delete :destroy, params: { id: doctor_2.id }
#       doctors = Doctor.all.map { |doctor| doctor.id }
#
#       expect(doctors.length).to eq(1)
#       expect(doctors.find { |id| id == doctor_2.id }).to be(nil)
#     end
#   end
# end








require 'test_helper'

class DoctorsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @doctor = doctors(:doctor_1)
  end

  test "should get index" do
    get doctors_url
    assert_response :success
  end

  test "should show doctor" do
    get doctor_url(@doctor)
    assert_response :success
  end

  test "should get new" do
    get new_doctor_url
    assert_response :success
  end

  test "should create doctor" do
    assert_difference('Doctor.count') do
      post doctors_url, params: { doctor: { name: @doctor.name } }
    end

    assert_redirected_to doctor_url(Doctor.last)
  end

  test "should get edit" do
    get edit_doctor_url(@doctor)
    assert_response :success
  end

  test "should update doctor" do
    patch doctor_url(@doctor), params: { doctor: { name: @doctor.name } }
    assert_redirected_to doctor_url(@doctor)
  end

  test "should destroy doctor" do
    assert_difference('Doctor.count', -1) do
      delete doctor_url(@doctor)
    end

    assert_redirected_to doctors_url
  end
end

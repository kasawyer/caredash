require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @doctor = doctors(:doctor_1)
    @review = reviews(:review_1)
  end

  test "should get index" do
    get doctor_reviews_url(@doctor)
    assert_response :success
  end

  test "should show review" do
    get doctor_reviews_url(@doctor)
    assert_response :success
  end

  test "should get new" do
    get new_doctor_review_url(@doctor)
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post "/doctors/#{@doctor.id}/reviews", params: { review: { description: @review.description } }
    end

    assert_redirected_to "/doctors/#{@doctor.id}/reviews/#{@review.id}"
  end

  test "should get edit" do
    get edit_doctor_review_url(@doctor, @review)
    assert_response :success
  end

  test "should update review" do
    patch doctor_review_url(@doctor, @review), params: { review: { description: @review.description } }
    assert_redirected_to doctor_review_url(@doctor, @review)
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete doctor_review_url(@doctor, @review)
    end

    assert_redirected_to doctor_reviews_url(@doctor)
  end
end

require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @review = reviews(:review_1)
  end

  test "should get index" do
    get doctor_reviews_url
    assert_response :success
  end

  test "should show review" do
    get doctor_reviews_url(@review)
    assert_response :success
  end

  test "should get new" do
    get new_doctor_review_url
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post doctor_reviews_url, params: { review: { description: @review.description } }
    end

    assert_redirected_to doctor_review_url(Review.last)
  end

  test "should get edit" do
    get edit_doctor_review_url(@review)
    assert_response :success
  end

  test "should update review" do
    patch doctor_review_url(@review), params: { review: { description: @review.description } }
    assert_redirected_to doctor_review_url(@review)
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete doctor_review_url(@review)
    end

    assert_redirected_to doctor_reviews_url
  end
end

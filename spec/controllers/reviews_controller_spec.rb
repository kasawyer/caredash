require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  let!(:doctor1) { FactoryGirl.create(:doctor) }
  let!(:review1) { FactoryGirl.create(:review, doctor: doctor1) }

  let!(:doctor2) do
    FactoryGirl.create(:doctor,
      name: "Doctor Jones",
      created_at: "2017-03-25T22:22:03.323Z",
      updated_at: "2017-03-25T22:22:03.323Z")
  end

  let!(:review2) do
    FactoryGirl.create(:review,
      doctor: doctor2,
      description: "Bad experience",
      created_at: "2017-03-25T22:22:35.633Z",
      updated_at: "2017-03-25T22:22:35.633Z")
  end

  let!(:review3) do
    FactoryGirl.create(:review,
      doctor: doctor1,
      description: "Love her!",
      created_at: "2017-03-25T22:22:56.271Z",
      updated_at: "2017-03-25T22:22:56.271Z")
  end

  describe "GET #index" do
    it "should return all the reviews for a specific doctor and that doctor" do
      get :index, params: { doctor_id: doctor1.id }
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json[0]["description"]).to eq("Great!")
      expect(json[1]["description"]).to eq("Love her!")
      expect(json[0]["doctor"]["name"]).to eq("Doctor Sawyer")
      expect(json[1]["doctor"]["name"]).to eq("Doctor Sawyer")
      expect(json).not_to include("Bad experience")
      expect(json).not_to include("Doctor Jones")
    end
  end

  describe "GET #show" do
    it "should return a specific review and the related doctor" do
      get :show, params: { doctor_id: doctor1.id, id: review1.id }
      json = JSON.parse(response.body)
      expect(json["description"]).to eq("Great!")
      expect(json["doctor"]["name"]).to eq("Doctor Sawyer")
      expect(json).not_to include("Love her!")
      expect(json).not_to include("Bad experience")
    end
  end

  describe "POST #create" do
    it "should create a new review object" do
      post :create, params: { doctor_id: doctor2.id, review: FactoryGirl.attributes_for(:review,
        description: "Great doctor",
        created_at: "2017-03-25T22:22:58.271Z",
        updated_at: "2017-03-25T22:22:58.271Z"
      )}
      get :index, params: { doctor_id: doctor2.id }
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json[1]["description"]).to eq("Great doctor")
    end

    it "redirects to the new review" do
      post :create, params: { doctor_id: doctor2.id, review: FactoryGirl.attributes_for(:review,
        description: "Great doctor",
        created_at: "2017-03-25T22:22:58.271Z",
        updated_at: "2017-03-25T22:22:58.271Z"
      )}
      expect(response).to redirect_to doctor_review_url(doctor2, Review.last)
    end
  end

  describe "PUT #update" do
    it "should update the review object" do
      put :update, params: { doctor_id: doctor1, id: review1, review: {
        description: "Not great"
      }}
      get :index, params: { doctor_id: doctor1.id }
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.first["description"]).to eq("Not great")
    end

    it "redirects to the review's page" do
      put :update, params: { doctor_id: doctor1.id, id: review1, review: FactoryGirl.attributes_for(:review,
        description: "Not great"
      )}
      expect(response).to redirect_to doctor_review_url(doctor1, review1)
    end
  end

  describe "DELETE #destroy" do
    it "should delete the review" do
      delete :destroy, params: { doctor_id: doctor1.id, id: review1.id }
      reviews = Review.all.map { |review| review.id }

      expect(reviews.length).to eq(2)
      expect(reviews.find { |id| id == review1.id }).to be(nil)
    end
  end
end

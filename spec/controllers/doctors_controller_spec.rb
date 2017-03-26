require "rails_helper"

RSpec.describe DoctorsController, type: :controller do
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
    it "should return all the doctors and their reviews" do
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json[0]["name"]).to eq("Doctor Sawyer")
      expect(json[0]["reviews"][0]["description"]).to eq("Great!")
      expect(json[0]["reviews"][1]["description"]).to eq("Love her!")
      expect(json[1]["name"]).to eq("Doctor Jones")
      expect(json[1]["reviews"][0]["description"]).to eq("Bad experience")
    end
  end

  describe "GET #show" do
    it "should return a specific doctor and their reviews" do
      get :show, params: { id: doctor1.id }
      json = JSON.parse(response.body)
      expect(json["name"]).to eq("Doctor Sawyer")
      expect(json["reviews"][0]["description"]).to eq("Great!")
      expect(json["reviews"][1]["description"]).to eq("Love her!")
      expect(json).not_to include("Doctor Jones")
    end
  end

  describe "POST #create" do
    it "should create a new doctor object" do
      post :create, params: { doctor: FactoryGirl.attributes_for(:doctor,
        name: "Doctor Brown",
        created_at: "2017-03-25T22:22:58.271Z",
        updated_at: "2017-03-25T22:22:58.271Z"
      )}
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(3)
      expect(json[2]["name"]).to eq("Doctor Brown")
    end

    it "redirects to the new doctor" do
      post :create, params: { doctor: FactoryGirl.attributes_for(:doctor,
        name: "Doctor Brown",
        created_at: "2017-03-25T22:22:58.271Z",
        updated_at: "2017-03-25T22:22:58.271Z"
      )}
      expect(response).to redirect_to Doctor.last
    end
  end

  describe "PUT #update" do
    it "should update the doctor object" do
      put :update, params: { id: doctor1, doctor: FactoryGirl.attributes_for(:doctor,
        name: "Doctor K. Sawyer"
      )}
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.last["name"]).to eq("Doctor K. Sawyer")
    end

    it "redirects to the doctor's page" do
      put :update, params: { id: doctor1, doctor: FactoryGirl.attributes_for(:doctor,
        name: "Doctor K. Sawyer"
      )}
      expect(response).to redirect_to Doctor.first
    end
  end

  describe "DELETE #destroy" do
    it "should delete the doctor and all reviews" do
      delete :destroy, params: { id: doctor1.id }
      doctors = Doctor.all.map { |doctor| doctor.id }
      reviews = Review.all.map { |review| review.id }

      expect(doctors.length).to eq(1)
      expect(doctors.find { |id| id == doctor1.id }).to be(nil)
      expect(reviews.length).to eq(1)
    end
  end
end

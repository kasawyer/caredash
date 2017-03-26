require 'spec_helper'

describe Review do
  let!(:review) { FactoryGirl.create(:review) }

  describe ".new" do
    it "has a description" do
      expect(review.description).to eq("Great!")
    end
    it "has a doctor" do
      expect(review.doctor.name).to eq("Doctor Sawyer")
    end
    it "has a created_at timestamp" do
      expect(review.created_at).to eq("2017-03-25T22:09:02.162Z")
    end
    it "has an updated_at timestamp" do
      expect(review.updated_at).to eq("2017-03-25T22:09:02.162Z")
    end
  end
end

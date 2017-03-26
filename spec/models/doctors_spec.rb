require 'spec_helper'

describe Doctor do
  let!(:doctor) { FactoryGirl.create(:doctor) }

  describe ".new" do
    it "has a name" do
      expect(doctor.name).to eq("Doctor Sawyer")
    end
    it "has a created_at timestamp" do
      expect(doctor.created_at).to eq("2017-03-25T22:08:35.055Z")
    end
    it "has an updated_at timestamp" do
      expect(doctor.updated_at).to eq("2017-03-25T22:08:35.055Z")
    end
  end
end

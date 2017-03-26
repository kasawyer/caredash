FactoryGirl.define do
  factory :review do
    description "Great!"
    doctor_id 1
    created_at "2017-03-25T22:09:02.162Z"
    updated_at "2017-03-25T22:09:02.162Z"

    doctor
  end
end

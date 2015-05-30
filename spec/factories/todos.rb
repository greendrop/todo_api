FactoryGirl.define do
  factory :todo do
    user { create(:user) }
    title "title"
    description "description"
    state 'none'
  end

end

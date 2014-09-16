Fabricator(:user) do
  provider "github"
  uid {Faker::Number.number(5)}
  name { Faker::Name.name }
  verified false
  gravatar_id "7194e8d48fa1d2b689f99443b767316c"
end


Fabricator(:verified_user, from: :user) do
  verified true
end
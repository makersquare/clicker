Fabricator(:user) do
  provider "github"
  uid 123
  name { Faker::Name.name }
  verified false
  gravatar_id "7194e8d48fa1d2b689f99443b767316c"
end

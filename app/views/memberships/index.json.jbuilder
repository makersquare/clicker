json.array!(@memberships) do |membership|
  json.extract! membership, :id, :teacher
  json.url membership_url(membership, format: :json)
end

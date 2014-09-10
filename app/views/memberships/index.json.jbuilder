json.array!(@memberships) do |membership|
  json.extract! membership, :id, :kind
  json.url membership_url(membership, format: :json)
end

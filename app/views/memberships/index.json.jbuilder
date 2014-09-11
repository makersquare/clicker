json.array!(@memberships) do |membership|
  json.extract! membership, :id, :kind
  json.url class_group_membership_url(@class_group, membership, format: :json)
end


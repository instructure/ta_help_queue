json.array!(@admins) do |admin|
  json.extract! admin, :id, :admin_id, :password, :name
  json.url admin_url(admin, format: :json)
end

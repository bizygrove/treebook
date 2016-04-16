json.array!(@admin_admins) do |admin_admin|
  json.extract! admin_admin, :id, :email, :password
  json.url admin_admin_url(admin_admin, format: :json)
end

json.array!(@camp_instructors) do |i|
  json.extract! i, :id, :first_name, :last_name, :bio, :user_id, :active
  json.url instructor_url(i, format: :json)
end
json.array!(@instructors) do |instructor|
  json.extract! instructor, :id, :first_name, :last_name, :bio
  json.url camp_instructor_url(instructor, format: :json)
end
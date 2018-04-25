json.array!(@instructors) do |instructor|
  json.extract! instructor, :id, :bio, :image, :proper_name
  json.url camp_instructors_for_url(instructor, format: :json)
end
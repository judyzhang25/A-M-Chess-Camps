json.array!(@camp_instructors) do |ci|
  json.extract! ci, :id, :instructor_id, :camp_id
  json.url camp_instructor_url(ci, format: :json)
end
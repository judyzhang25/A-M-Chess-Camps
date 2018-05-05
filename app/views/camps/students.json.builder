json.array!(@students) do |s|
  json.extract! s, :id, :first_name, :last_name, :family_id, :rating, :active
  json.url student_url(s, format: :json)
end
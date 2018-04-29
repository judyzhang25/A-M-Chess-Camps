json.array!(@active_camps) do |camp|
  json.extract! camp, :id, :curriculum_id, :location_id
  start_time = (camp.time_slot = "am") ? DateTime.new(camp.start_date.year, camp.start_date.month, camp.start_date.day, 9, 30) : DateTime.new(camp.start_date.year, camp.start_date.month, camp.start_date.day, 13, 30)
  end_time = (camp.time_slot = "am") ? DateTime.new(camp.end_date.year, camp.end_date.month, camp.end_date.day, 12, 30) : DateTime.new(camp.end_date.year, camp.end_date.month, camp.end_date.day, 16, 30)
  json.title camp.name
  json.start start_time.strftime('%Y-%m-%dT%H:%M:%S')
  json.end end_time.strftime('%Y-%m-%dT%H:%M:%S')
  json.url camp_url(camp, format: :html)
end
if current_user.role?(:parent)
  json.array!(current_role.registrations) do |r|
    if r.camp.start_date >= Date.today
      json.extract! r, :id
      if r.camp.time_slot == "am"
        json.backgroundColor '#5aaa95'
      end
      start_time = (r.camp.time_slot == "am") ? DateTime.new(r.camp.start_date.year, r.camp.start_date.month, r.camp.start_date.day, 9, 30) : DateTime.new(r.camp.start_date.year, r.camp.start_date.month, r.camp.start_date.day, 13, 30)
      end_time = (r.camp.time_slot == "am") ? DateTime.new(r.camp.end_date.year, r.camp.end_date.month, r.camp.end_date.day, 12, 30) : DateTime.new(r.camp.end_date.year, r.camp.end_date.month, r.camp.end_date.day, 16, 30)
      json.title r.camp.name
      json.start start_time.strftime('%Y-%m-%dT%H:%M:%S')
      json.end end_time.strftime('%Y-%m-%dT%H:%M:%S')
      json.url camp_url(r.camp, format: :html)
    end
  end
else
  json.array!(current_role.camps) do |camp|
    json.extract! camp, :id, :time_slot
    if camp.time_slot == "am"
      start_time=DateTime.new(camp.start_date.year, camp.start_date.month, camp.start_date.day, 9, 30)
      end_time = DateTime.new(camp.end_date.year, camp.end_date.month, camp.end_date.day, 12, 30)
      json.backgroundColor '#5aaa95'
    else
      start_time=DateTime.new(camp.start_date.year, camp.start_date.month, camp.start_date.day, 13, 30)
      end_time = DateTime.new(camp.end_date.year, camp.end_date.month, camp.end_date.day, 16, 30)
    end
    json.title camp.name
    json.start start_time.strftime('%Y-%m-%dT%H:%M:%S')
    json.end end_time.strftime('%Y-%m-%dT%H:%M:%S')
    json.url camp_url(camp, format: :html)
  end
end
json.array!(@students) do |student|
  json.extract! student, :id, :name, :id_num
  json.url student_url(student, format: :json)
end

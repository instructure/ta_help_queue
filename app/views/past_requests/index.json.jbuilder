json.array!(@past_requests) do |past_request|
  json.extract! past_request, :id, :student_id, :removed_by, :time_waited, :received_help
  json.url past_request_url(past_request, format: :json)
end

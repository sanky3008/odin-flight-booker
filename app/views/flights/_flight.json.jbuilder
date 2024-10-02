json.extract! flight, :id, :date, :name, :departure_id, :arrival_id, :vacancy, :created_at, :updated_at
json.url flight_url(flight, format: :json)

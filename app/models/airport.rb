class Airport < ApplicationRecord
  has_many :departing_flights, foreign_key: "departure_id", class_name: "Flight"
  has_many :arriving_flights, foreign_key: "arrival_id", class_name: "Flight"
end

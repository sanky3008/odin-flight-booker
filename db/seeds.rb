# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Airport.destroy_all
Flight.destroy_all

# Create Airports
airports = [
  { city: "Delhi", code: "DEL" },
  { city: "Mumbai", code: "BOM" },
  { city: "Bangalore", code: "BLR" },
  { city: "Chennai", code: "MAA" },
  { city: "Kolkata", code: "CCU" },
  { city: "Hyderabad", code: "HYD" },
  { city: "Ahmedabad", code: "AMD" },
  { city: "Goa", code: "GOI" },
  { city: "Jaipur", code: "JAI" },
  { city: "Kochi", code: "COK" }
]

airports.each do |airport|
  Airport.create!(airport)
end

# Helper method to get random date within next 30 days
def random_date
  DateTime.now + rand(1..30).days
end

# Create Flights
50.times do |i|
  departure = Airport.all.sample
  arrival = (Airport.all - [departure]).sample

  Flight.create!(
    date: random_date,
    name: "FL#{sprintf('%04d', i+1)}",
    departure_id: departure.id,
    arrival_id: arrival.id,
    vacancy: rand(50..200)
  )
end

puts "Created #{Airport.count} airports and #{Flight.count} flights."

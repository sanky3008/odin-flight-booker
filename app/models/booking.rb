class Booking < ApplicationRecord
  belongs_to :flight
  belongs_to :passenger
  accepts_nested_attributes_for :passenger
  accepts_nested_attributes_for :flight
end

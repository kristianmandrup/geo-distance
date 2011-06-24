require 'sugar-high/array'

class GeoDistance
  include GeoUnits

  module Formula
    autoload_modules :Haversine :Spherical, :Vincenty, :NVector, :Flat
  end 
end
    
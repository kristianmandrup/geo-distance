require 'sugar-high/array'

class GeoDistance
  module Formula
    autoload_modules :Haversine :Spherical, :Vincenty, :NVector, :Flat
  end 
end
    
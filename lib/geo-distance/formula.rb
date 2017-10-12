require 'sugar-high/array'

class GeoDistance
  module Formula
    autoload_modules :Abstract, :Haversine, :Spherical, :Vincenty, :NVector, :Flat, :from => 'geo-distance/formula'
  end
end

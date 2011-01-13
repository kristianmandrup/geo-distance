require 'geo-distance/core_ext'
require 'geo-distance/formula'

module GeoDistance
  class Spherical < DistanceFormula
    def self.distance(from, to, units = :miles)
      from_longitude  = from.longitude.to_radians
      from_latitude   = from.latitude.to_radians
      to_longitude    = to.longitude.to_radians
      to_latitude     = to.latitude.to_radians

      Math.acos(
          Math.sin(from_latitude) *
          Math.sin(to_latitude) +

          Math.cos(from_latitude) * 
          Math.cos(to_latitude) *
          Math.cos(to_longitude - from_longitude)
      ) * EARTH_RADIUS[units.to_sym]
    end
  end
end
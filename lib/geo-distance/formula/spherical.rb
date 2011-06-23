require 'geo-distance/core_ext'
require 'geo-distance/formula'

# module GeoDistance
#   class Spherical < DistanceFormula
#     def self.distance( lat1, lon1, lat2, lon2) 
#       from_longitude  = lon1.to_radians
#       from_latitude   = lat1.to_radians
#       to_longitude    = lon2.to_radians
#       to_latitude     = lat2.to_radians
# 
#       c = Math.acos(
#           Math.sin(from_latitude) *
#           Math.sin(to_latitude) +
# 
#           Math.cos(from_latitude) * 
#           Math.cos(to_latitude) *
#           Math.cos(to_longitude - from_longitude)
#       ) #* EARTH_RADIUS[units.to_sym]
#       
#       GeoDistance::Distance.new c
#     end
#   end
# end   

class GeoDistance
  class Spherical < DistanceFormula
    def self.distance *args
      from, to, units = get_points(args)        
      
      return 0.0 if from == to #return 0.0 if points are have the same coordinates

      c = Math.acos( 
        Math.sin(degrees_to_radians(from.lat)) * Math.sin(degrees_to_radians(to.lat)) + 
        Math.cos(degrees_to_radians(from.lat)) * Math.cos(degrees_to_radians(to.lat)) * 
        Math.cos(degrees_to_radians(to.lng) - degrees_to_radians(from.lng))
      ).to_deg
      
      units ? c.radians_to(units) : c
    rescue Errno::EDOM
      0.0
    end
  end
end
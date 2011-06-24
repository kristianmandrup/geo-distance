require 'geo-distance/core_ext'
require 'geo-distance/formula'

class GeoDistance
  class Spherical < DistanceFormula
    def initialize options = {}
      super
    end
    
    def distance *args
      from, to, units = get_points(args)        
      lat1, lon1, lat2, lon2 = [from.lat, from.lng, to.lat, to.lng].map{|deg| deg.rpd }

      return 0.0 if from == to #return 0.0 if points are have the same coordinates

      c = Math.acos( 
        Math.sin(lat1) * Math.sin(lat2) + 
        Math.cos(lat1) * Math.cos(lat2) * 
        Math.cos(lon2 - lon1)
      ).to_deg
      
      units ? c.radians_to(units) : c
    rescue Errno::EDOM
      0.0
    end
  end
end
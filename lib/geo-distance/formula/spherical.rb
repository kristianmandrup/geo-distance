require 'geo-distance/core_ext'
require 'geo-distance/formula'

class GeoDistance
  class Spherical < DistanceFormula
    def initialize options = {}
      super
    end
    
    def distance *args
      from, to, units = get_points(args)        
      [from, to].to_radians!

      return 0.0 if from == to #return 0.0 if points are have the same coordinates

      c = Math.acos( 
        Math.sin(from.lat) * Math.sin(to.lat) + 
        Math.cos(from.lat) * Math.cos(to.lat) * 
        Math.cos(to.lon - from.lon)
      ).to_deg

      # something odd here! radians and degrees are mixed up!
      units ? c.radians_to(units) : c
    rescue Errno::EDOM
      0.0
    end
  end
end
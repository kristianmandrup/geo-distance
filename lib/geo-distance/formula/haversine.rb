# translated into Ruby based on information contained in:
#   http://mathforum.org/library/drmath/view/51879.html  Doctors Rick and Peterson - 4/20/99
#   http://www.movable-type.co.uk/scripts/latlong.html
#   http://en.wikipedia.org/wiki/Haversine_formula
#
# This formula can compute accurate distances between two points given latitude and longitude, even for
# short distances.
 
require 'geo-distance/core_ext'
require 'geo-distance/formula'

class GeoDistance
  class Haversine < DistanceFormula
    # given two lat/lon points, compute the distance between the two points using the haversine formula
    #  the result will be a Hash of distances which are key'd by 'mi','km','ft', and 'm'

    def initialize options = {}
      super
    end
    
    def distance *args
      begin
        from, to, units = get_points(args)
        [from, to].to_radians!

        dlon = to.lng - from.lng
        dlat = to.lat - from.lat
    
        a = (Math.sin(dlat/2))**2 + Math.cos(from.lng) * Math.cos(to.lng) * (Math.sin(dlon/2))**2
        c = (2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))).to_deg
                
        units ? c.radians_to(units) : c
      rescue Errno::EDOM
        0.0        
      end
    end  
  end  
end 
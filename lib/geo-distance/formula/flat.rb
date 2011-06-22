require 'geo-distance/core_ext'
require 'geo-distance/formula'

class GeoDistance
  class Flat < DistanceFormula

    # Calculate the distance between two Locations using the Vincenty formula
    #
    #   GeoDistance.distance(29, 10, 34, -5)
    #
    # def self.distance lat1, lon1, lat2, lon2, options = {}
    #   from = {:lat => lat1, :lng => lng1}
    #   to =   {:lat => lat2, :lng => lng2}      

    def self.distance *args
      from, to, units = get_points(args)

      return 0 if from == to #return 0.0 if points are have the same coordinates      

      Math.sqrt(
        (units_per_latitude_degree(units) * (from.lat - to.lat))**2 +
        (units_per_longitude_degree(from.lat, units) * (from.lng - to.lng))**2
      )
    end
  end
end



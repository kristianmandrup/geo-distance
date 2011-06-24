require 'geo-distance/core_ext'
require 'geo-distance/formula'

class GeoDistance
  module Formula
    class Flat < Abstract
      def initialize options = {}
        super
      end

      # Calculate distance using Flat earth formula, returns distance in whatever unit is specified (kms by default)
      def distance *args
        from, to, units = get_points(args)

        return 0 if from == to # return 0.0 if points are have the same coordinates      

        Math.sqrt(
          (units_per_latitude_degree(units) * (from.lat - to.lat))**2 +
          (units_per_longitude_degree(from.lat, units) * (from.lng - to.lng))**2
        )
      end
    end
  end
end

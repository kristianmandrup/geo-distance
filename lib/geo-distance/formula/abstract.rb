require 'sugar-high/array'

module GeoDistance
  module Formula
    class Abstract
      extend Math
      extend GeoUnits

      attr_reader :globe
   
      def initialize globe = nil
        @globe = globe || GeoDistance::Earth.new
      end

      PI = Math::PI

      # use underlying distance formula
      def geo_distance *args
        options = args.extract_options!
        GeoDistance.new distance(args), get_units(options)
      end

      # used to convert various argument types into GeoPoints
      def get_points(*args)
        args.flatten!
        options = args.extract_options!
        units = options[:units] || GeoDistance.default_units

        case args.size
        when 2
          [GeoPoint.new(args.first), GeoPoint.new(args.last), units]
        when 4
          [GeoPoint.new(args[0..1]), GeoPoint.new(args[2..3]), units]
        else
          raise "Distance from point A to B, must be given either as 4 arguments (lat1, lng1, lat2, lng2) or 2 arguments: (pointA, pointB), was: #{args}"
        end        
      end

      # used to get the units for how to calculate the distance
      def get_units options = {}
        GeoUnits.key(options[:units] || :kms)
      end        
    end
  end
end
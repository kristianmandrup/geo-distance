class GeoDistance
  include GeoUnits
  
  class DistanceFormula
    extend Math
    extend GeoUnits
     
    def initialize
      raise NotImplementedError
    end  

    # use underlying distance formula
    def self.geo_distance *args
      GeoDistance.new distance(args), get_units(args.last_option)
    end

    # used to convert various argument types into GeoPoints
    def self.get_points(*args)
      args.flatten!
      options = args.delete(args.last_option) || {}
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
    def self.get_units options = {}
      GeoUnits.key(options[:units] || :kms)
    end
        
    # def self.degrees_to_radians(degrees)   
    #   # degrees.to_f / 180.0 * Math::PI
    #   degrees.to_f * radians_per_degree
    # end

    # def self.units_sphere_multiplier(units)
    #   earth_radius_map[GeoUnit.key units]
    # end
    # 
    # def self.units_per_latitude_degree(units)
    #   GeoUnits.radian_multiplier[units.to_sym]
    # end
    # 
    # def self.units_per_longitude_degree(lat, units)
    #   miles_per_longitude_degree = (latitude_degrees * Math.cos(lat * pi_div_rad)).abs
    #   case units
    #     when :kms
    #       miles_per_longitude_degree * kms_per_mile
    #     when :miles
    #       miles_per_longitude_degree
    #   end
    # end    
  end
end
    
class GeoDistance  
  # WGS-84 numbers
  
  EARTH_RADIUS = { 
    :miles      => 3963.1676, 
    :kilometers => 6378.135, 
    :meters     =>  6378135, 
    :feet       => 20925639.8 
  }


  EARTH_MAJOR_AXIS_RADIUS = { 
    :miles      => 3963.19059, 
    :kilometers => 6378.137,
    :meters     => 6378137,
    :feet       => 20925646.36
  }

  EARTH_MINOR_AXIS_RADIUS = { 
    :kilometers => 6356.7523142,
    :miles      => 3949.90276,
    :meters     => 6356752.3142,
    :feet       => 20855486.627
  }

  class DistanceFormula
    include Math
    extend Math

    RADIAN_PER_DEGREE = Math::PI / 180.0

    # Haversine Formula
    # Adapted from Geokit Gem
    # https://github.com/andre/geokit-gem.git
    # By: Andre Lewis
    PI_DIV_RAD = 0.0174

    KMS_PER_MILE = 1.609
    METERS_PER_FEET = 3.2808399

    MILES_PER_LATITUDE_DEGREE = 69.1
    KMS_PER_LATITUDE_DEGREE = MILES_PER_LATITUDE_DEGREE * KMS_PER_MILE
    LATITUDE_DEGREES = EARTH_RADIUS[:miles] / MILES_PER_LATITUDE_DEGREE
     
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
        
    def self.degrees_to_radians(degrees)
      degrees.to_f / 180.0 * Math::PI
    end

    def self.units_sphere_multiplier(units)
      EARTH_RADIUS[GeoUnit.key units]
    end

    def self.units_per_latitude_degree(units)
      GeoUnits.radian_multiplier[units.to_sym]
    end

    def self.units_per_longitude_degree(lat, units)
      miles_per_longitude_degree = (LATITUDE_DEGREES * Math.cos(lat * PI_DIV_RAD)).abs
      case units
        when :kms
          miles_per_longitude_degree * KMS_PER_MILE
        when :miles
          miles_per_longitude_degree
      end
    end    
  end
end
    
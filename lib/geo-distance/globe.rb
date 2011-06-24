module GeoDistance
  autoload_modules :Earth, :from => 'geo_distance'
  
  class Globe
    attr_reader :radius, :minor_axis_radius, :major_axis_radius
     
    def initialize options = {}
      @radius = options[:radius]
      @minor_axis_radius = options[:minor_axis_radius]
      @major_axis_radius = options[:major_axis_radius]
    end

    def miles_per_latitude_degree 
      69.1
    end

    def kms_per_latitude_degree
      miles_per_latitude_degree * kms_per_mile
    end

    def latitude_degrees 
      earth_radius_map[:miles] / miles_per_latitude_degree
    end 
        
    def units_sphere_multiplier(units)
      units = GeoUnits.key units
      radius[units]
    end

    def units_per_latitude_degree(units)
      units = GeoUnits.key units
      GeoUnits::Maps.radian_multiplier[units]
    end

    def units_per_longitude_degree(lat, units)
      miles_per_longitude_degree = (latitude_degrees * Math.cos(lat * pi_div_rad)).abs 
      units = GeoUnits.key units
      miles_per_longitude_degree.miles_to(units)
    end 

    def earth_radius units
      units = GeoUnits.key units
      GeoUnits::Maps.earth_radius_map[units]
    end
    
    def radians_ratio units
      units = GeoUnits.key units
      radians_per_degree * earth_radius(units)
    end    
  end
end
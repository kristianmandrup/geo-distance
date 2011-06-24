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
      raise NotImplementedError
    end

    def kms_per_latitude_degree
      miles_per_latitude_degree * kms_per_mile
    end

    def latitude_degrees 
      radius.to_miles / miles_per_latitude_degree
    end 
        
    def units_sphere_multiplier(units)
      units = GeoUnits.key units
      radius.to_units(units)
    end

    def units_per_latitude_degree(units)
      degree_multiplier unit_key(units)
    end

    def units_per_longitude_degree(lat, units)
      miles_per_longitude_degree = (latitude_degrees * Math.cos(lat * pi_div_rad)).abs 
      miles_per_longitude_degree.miles_to unit_key(units)
    end 
    
    def radians_ratio units
      radians_per_degree * radius.to_units(unit_key(units))
    end  
    
    protected

    def unit_key units
      GeoUnits.key units
    end
    
    def degree_multiplier units
      GeoUnits::Maps.degree_multiplier[units]  
    end
  end
end
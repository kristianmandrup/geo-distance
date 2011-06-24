module GeoDistance
  class Earth < Globe
    attr_reader :radius, :minor_axis_radius, :major_axis_radius
     
    def initialize options = {}
      super
    end

    def radius name = nil
      @radius ||= globe.radius(:kms)
    end

    protected
    
    def minor_axis_radius    
      @minor_axis_radius ||= globe.minor_axis_radius(:kms)
    end
    
    def major_axis_radius    
      @major_axis_radius ||= globe.major_axis_radius(:kms)
    end

    def globe
      GeoUnits::Globe::Earth
    end
    
    def miles_per_latitude_degree 
      69.1
    end

    def kms_per_latitude_degree
      miles_per_latitude_degree * kms_per_mile
    end

    def latitude_degrees 
      radius_in(:miles) / miles_per_latitude_degree
    end
  end
end
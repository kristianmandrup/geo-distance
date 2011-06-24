class GeoDistance 
  # this is global because if computing lots of track point distances, it didn't make 
  # sense to new a Hash each time over potentially 100's of thousands of points

  def self.formulas
    [:flat, :haversine, :spherical, :vincenty, :nvector]
  end

  formulas.each do |formula|
    class_eval %{
      def self.#{formula}_distance *args
        GeoDistance.distance args, :formula => :#{formula}
      end

      def self.#{formula}_geo_distance *args
        GeoDistance.geo_distance args, :formula => :#{formula}
      end
    }
  end

  module ClassMethods
    # radius of the great circle in miles
    # radius in kilometers...some algorithms use 6367
        
    def distance *args
      puts "Class: #{distance_class(*args)}"
      distance_class(*args).distance *args
    end

    def geo_distance *args
      puts "Class: #{distance_class(*args)}"
      distance_class(*args).geo_distance *args
    end

    def distance_class *args    
      formula = args.last_option[:formula] || default_formula
      "GeoDistance::#{formula.to_s.camelize}".constantize
    rescue
      raise ArgumentError, "Not a valid formula. Must be one of: #{formulas}"
    end

    def default_units= name
      raise ArgumentError, "Not a valid units. Must be one of: #{all_units}" if !all_units.include?(name.to_sym)
      @default_units = GeoUnits.key(name)
    end

    def default_units
      @default_units || :kms
    end

    def default_formula= name
      raise ArgumentError, "Not a valid formula. Must be one of: #{formulas}" if !formulas.include?(name.to_sym)
      @default_formula = name 
    end
    
    def default_algorithm 
      @default_algorithm || :haversine
    end

    def earth_radius units
      GeoUnits.earth_radius units
    end

    def radians_per_degree
      0.017453293  #  PI/180
    end    
        
    def radians_ratio unit
      GeoDistance.radians_per_degree * earth_radius[unit]          
    end

    def all_units
      GeoUnits.all_units
    end

    def units 
      GeoUnits.units
    end    
  end
  
  extend ClassMethods  
end
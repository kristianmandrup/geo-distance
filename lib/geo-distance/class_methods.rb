class GeoDistance 
  def self.formulas
    [:flat, :haversine, :spherical, :vincenty, :nvector]
  end

  formulas.each do |formula|
    class_eval %{
      def self.#{formula} *args
        GeoDistance.distance args, :formula => :#{formula}
      end

      def self.#{formula}_dist *args
        GeoDistance.geo_distance args, :formula => :#{formula}
      end
    }
  end

  module ClassMethods        
    def distance *args
      distance_calculator(*args).distance *args
    end

    def geo_distance *args      
      distance_calculator(*args).geo_distance *args
    end

    def default_units= name
      raise ArgumentError, "Not a valid units. Must be one of: #{all_units}" if !all_units.include?(name.to_sym)
      @default_units = GeoUnits.key(name)
    end

    def default_units
      @default_units || :kms
    end

    def default_globe= globe
      raise ArgumentError, "Not a valid globe. Must be an instance of: GeoDistance::Globe" if !globe.kind_of? GeoDistance::Globe
      @default_globe = globe
    end

    def default_globe
      @default_globe ||= GeoDistance::Globe::Earth.new
    end

    def default_formula= name
      raise ArgumentError, "Not a valid formula. Must be one of: #{formulas}" if !formulas.include?(name.to_sym)
      @default_formula = name 
    end
    
    def default_formula 
      @default_formula || :haversine
    end  
    
    protected

    def distance_calculator *args
      options = args.last_option || {}
      distance_class(*args).new(options[:globe])      
    end
    
    def distance_class *args    
      formula = args.last_option[:formula] || default_formula
      "GeoDistance::#{formula.to_s.camelize}".constantize
    rescue
      raise ArgumentError, "Not a valid formula. Must be one of: #{formulas}"
    end    
  end
  
  extend ClassMethods  
end
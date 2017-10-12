require 'geo-distance/globe/earth'

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
      @default_globe ||= ::GeoDistance::Earth.new
    end

    def default_formula= name
      raise ArgumentError, "Not a valid formula. Must be one of: #{formulas}" if !formulas.include?(name.to_sym)
      @default_formula = name
    end

    def default_formula
      @default_formula || :haversine
    end

    alias_method :default_algorithm, :default_formula
    alias_method :default_algorithm=, :default_formula=

    def all_units
      GeoUnits.all_units
    end

    protected

    def distance_calculator *args
      clazz = distance_class(*args)
      options = args.last_option || {}
      clazz.new(options[:globe])
    end

    def distance_class *args
      formula = args.last_option[:formula] || default_formula
      clazz = "GeoDistance::Formula::#{formula.to_s.camelize}"
      clazz.constantize
    rescue
      raise ArgumentError, "No such class: #{clazz}. Not a valid formula. Must be one of: #{formulas}, was #{formula}"
    end
  end

  extend ClassMethods
end

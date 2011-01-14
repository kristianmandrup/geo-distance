module GeoDistance 
  # this is global because if computing lots of track point distances, it didn't make 
  # sense to new a Hash each time over potentially 100's of thousands of points

  class << self
    # radius of the great circle in miles
    # radius in kilometers...some algorithms use 6367
    def earth_radius
      {:km => 6371, :miles => 3956, :feet => 20895592, :meters => 6371000}                     
    end

    def radians_per_degree
      0.017453293  #  PI/180
    end    
    
    def units 
      [:miles, :km, :feet, :meters]
    end
    
    def radians_ratio unit
      GeoDistance.radians_per_degree * earth_radius[unit]          
    end
    
    def default_algorithm= name
      raise ArgumentError, "Not a valid algorithm. Must be one of: #{algorithms}" if !algorithms.include?(name.to_sym)
      @default_algorithm = name 
    end
    
    def distance( lat1, lon1, lat2, lon2) 
      klass = case default_algorithm
      when :haversine
        GeoDistance::Haversine
      when :spherical
        GeoDistance::Spherical        
      when :vincenty
        GeoDistance::Vincenty
      else
        raise ArgumentError, "Not a valid algorithm. Must be one of: #{algorithms}"
      end
      klass.distance lat1, lon1, lat2, lon2
    end
    
    def default_algorithm 
      @default_algorithm || :haversine
    end
    
    protected
    
    def algorithms
      [:haversine, :spherical, :vincenty]
    end
  end
    
  class Distance
    attr_reader :distance, :unit

    def initialize distance, unit = nil
      @distance = distance
      return if !unit

      raise ArgumentError, "Invalid unit: #{unit} - must be one of #{GeoDistance.units}" if !GeoDistance.units.include?(unit.to_sym)
      @unit = unit.to_sym
    end
    
    def [] key               
      method = :"delta_#{key}"
      raise ArgumentError, "Invalid unit key #{key}" if !respond_to? method
      Distance.send "in_#{key}", send(method)
    end

    GeoDistance.units.each do |unit|
      class_eval %{
        def #{unit}
          self[:#{unit}]
        end
      }
    end

    protected
    
    # delta between the two points in miles
    GeoDistance.units.each do |unit|
      class_eval %{
        def delta_#{unit}
          GeoDistance.earth_radius[:#{unit}] * distance
        end
      }
    end

    class << self            
      GeoDistance.units.each do |unit|
        class_eval %{
          def in_#{unit} number
            Unit.new :#{unit}, number
          end
        }
      end
    end
    
    class Unit
      attr_accessor :name, :number
      
      def initialize name, number = 0
        @name = name
        @number = number
      end

      def number
        @number.round_to(precision[name])
      end
      
      def to_s
        "#{number} #{name}"
      end
      
      private
      
      def precision
        {
          :feet => 0,
          :meters => 2,
          :km => 4,
          :miles => 4
        }
      end      
    end
  end
   
  def self.wants? unit_opts, unit
    unit_opts == unit || unit_opts[unit]    
  end
end

require 'geo-distance/haversine'
require 'geo-distance/spherical'
require 'geo-distance/vincenty'

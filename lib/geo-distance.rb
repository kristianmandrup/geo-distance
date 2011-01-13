require 'geo-distance/haversine'
require 'geo-distance/spherical'
require 'geo-distance/vincenty'

module GeoDistance

  RAD_PER_DEG = 0.017453293  #  PI/180
 
  # this is global because if computing lots of track point distances, it didn't make 
  # sense to new a Hash each time over potentially 100's of thousands of points

  class << self                
    def units 
      [:miles, :km, :feet, :meters]
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
    attr_reader :distance

    def initialize distance
      @distance = distance
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

    # the great circle distance d will be in whatever units R is in

    Rmiles = 3956           # radius of the great circle in miles
    Rkm = 6371              # radius in kilometers...some algorithms use 6367
    Rfeet = Rmiles * 5282   # radius in feet
    Rmeters = Rkm * 1000    # radius in meters
    
    # delta between the two points in miles
    def delta_miles 
      Rmiles * distance
    end
    
    # delta in kilometers
    def delta_km
      Rkm * distance
    end
    
    def delta_feet
      Rfeet * distance
    end
    
    def delta_meters
      Rmeters * distance
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
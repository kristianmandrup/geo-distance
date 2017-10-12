require 'sugar-high/numeric'
require 'geo-distance/class_methods'

module GeoDistanceExt
  ::GeoDistance.all_units.each do |unit|
    class_eval %{
      def #{unit}
        GeoDistance.new(self, :#{unit})
      end
    }
  end
end

class Numeric
  include GeoDistanceExt
end

class Array
  # used to convert GeoPoints to radians in distance formulas
  def to_radians!
    self.map! do |item|
      item.to_radians!
    end
  end
end

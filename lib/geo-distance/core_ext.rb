require 'sugar-high/numeric'

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


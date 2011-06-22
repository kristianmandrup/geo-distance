class GeoDistance 
  attr_reader :distance, :unit

  def initialize distance, unit = :kms
    @distance = distance
    return if !unit

    raise ArgumentError, "Invalid unit: #{unit} - must be one of #{GeoDistance.units}" if !GeoDistance.units.include?(unit.to_sym)
    @unit = unit.to_sym
  end

  GeoDistance.units.each do |unit|
    class_eval %{
      def #{unit}
        delta_#{unit}
      end
      alias_method :to_#{unit}, :#{unit}
    }
  end

  protected

  # delta between the two points in miles
  GeoDistance.units.each do |unit|
    class_eval %{
      def delta_#{unit}
        unit = GeoUnits.key(:#{unit})
        GeoDistance.earth_radius[:#{unit}] * distance
      end
    }
  end
end

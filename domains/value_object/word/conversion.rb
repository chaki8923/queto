

class Conversion
    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)

        return nil,'conversion is must be a string' unless value.is_a?(String)

        super(value)
    end
end
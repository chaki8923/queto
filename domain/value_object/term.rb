
class Term
    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)
        return nil,'term is must be a string' unless value.is_a?(String)
        return nil,'term is enter at least 2 characters' if value.length() < 2
    end
end
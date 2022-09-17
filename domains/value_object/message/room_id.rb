


class RoomId
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def self.new(value)
        return nil,'room_id is muust be a numeric' unless value.is_a?(Numeric)

        super(value)
    end

end
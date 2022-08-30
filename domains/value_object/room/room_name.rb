


class RoomName

    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)
        puts 'name!!!!'
        return nil,'admin_user is must be a string' unless value.is_a?(String)

        super(value)
    end
end
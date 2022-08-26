


class RoomAdminUser

    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)
        return nil,'admin_user is must be a numerical value' unless value.is_a?(Numeric)

        super(value)
    end
end
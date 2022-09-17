


class MessageContent

    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)

        return nil,'message content is must be a string' unless value.is_a?(String)
        
        super(value)
    end
end
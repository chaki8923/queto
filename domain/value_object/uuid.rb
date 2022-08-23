

class UuId
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def self.new(value)
        return nil,'uuid is must be a string' unless value.is_a?(String)
        
        uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
        return nil,'invalid uuid' unless uuid_regex.match?(value.to_s.downcase)

        super(value)
    end
end
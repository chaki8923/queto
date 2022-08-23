



class Upassword
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def self.new(value)
        return nil,'password is must be astring' unless value.is_a?(String)

        return nil,'password is enter at least 5 characters' if value.length() < 5
        return nil,'password is enter at less than 12 characters' if value.length() > 12

        super(value)
    end

end
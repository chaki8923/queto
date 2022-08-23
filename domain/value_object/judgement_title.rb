




class JudgementTitle
    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)
        return nil,'title is must be a string' unless value.is_a?(String)
        return nil,'title is enter at less than 20 characters' if value.length() > 20

        super(value)
    end
end
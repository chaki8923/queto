



class UadultFlg
    attr_reader :value
    
    def initialize(value)
        @value = value
    end

    def self.new(value)
        return nil,'adult_flg is must be boolean' unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
        super(value)
    end
end
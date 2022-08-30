

class RoomRequestFlg
    attr_reader :value
    
    def initialize(value)
        @value = value
    end

    def self.new(value)
        puts 'request_flg!!!'
        return nil,'requset_flg is must be boolean' unless value.is_a?(TrueClass) || value.is_a?(FalseClass) || value.to_i.zero?
        super(value)
    end
end
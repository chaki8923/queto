

class Uname
    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)

        return nil,'name is must be a string' unless value.is_a?(String)
        # duplication(value)

        super(value)
    end

    def duplication(value)
        # DB内との重複チェック記述予定
    end
end
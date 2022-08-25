


class Avatar
    attr_reader :value

    def initialize(value)
        @value = value
    end

    def self.new(value)

        return nil,'image is must be a string' unless value.is_a?(String)
        puts 'ファイルサイズ'
        puts File.size(value)
        return nil,'image is 5MB or less' if File.size(value) > 50000
       
        super(value)
    end

end
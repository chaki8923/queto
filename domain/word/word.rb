require 'uri'
require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }

class Word
    attr_reader :term,:conversion,:user_id

    def initialize(term,conversion,user_id)
        @term = term
        @conversion = conversion
        @user_id = user_id
    end

    def self.new(term,conversion,user_id)
        term,err = Term.new(term)
        return nil,err unless err.nil?
        conversion,err = Conversion.new(conversion)
        return nil,err unless err.nil?
        user_id ,err= UuId.new(user_id)
        return nil,err unless err.nil?

        super(term,conversion,user_id)
    end

    def self.create(term,conversion,user_id)
        new(term,conversion,SecureRandom.uuid)
    end
end
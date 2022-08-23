require 'uri'
require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }

class Word
    attr_reader :word_id,:term,:conversion,:user_id

    def initialize(word_id,term,conversion,user_id)
        @word_id = word_id
        @term = term
        @conversion = conversion
        @user_id = user_id
    end

    def self.new(word_id,term,conversion,user_id)
        word_id,err = UuId.new(word_id)
        return nil,err unless err.nil?

        term,err = Term.new(term)
        return nil,err unless err.nil?

        conversion,err = Conversion.new(conversion)
        return nil,err unless err.nil?

        user_id ,err= UuId.new(user_id)
        return nil,err unless err.nil?

        super(word_id,term,conversion,user_id)
    end

    def self.create(word_id,term,conversion,user_id)
        new(SecureRandom.uuid,term,conversion,SecureRandom.uuid)
    end
end
require 'securerandom'

Dir['./domain/value_object/*.rb'].sort.each { |file| require file }

class OldJudgement
    attr_reader :judgement_id,:title,:image

    def initialize(judgement_id,title,image)
        @judgement_id = judgement_id
        @title = title
        @image = image
    end

    def self.new(judgement_id,title,image)
        judgement_id,err = UuId.new(judgement_id)
        return nil,err unless err.nil?

        title,err = JudgementTitle.new(title)
        return nil,err unless err.nil?
        
        image,err = Uimage.new(image)
        return nil,err unless err.nil?

        super(judgement_id,title,image)
    end

    def self.create(title,iamge)
        new(SecureRandom.uuid,title,image)
    end

end
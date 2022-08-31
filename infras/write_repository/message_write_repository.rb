

class MessageWriteRepository

    def create(params)
        Message.create!(params)
    end

    def update(message)
        message.update(convert_old_message: message.content, convert_young_message: message.content)
    end

    def map_to_update(words,message,user)
        words.map do |word|
            if message.content.include?(word.term) && user.adult_flg == false # 若者が発した言葉のみ変換。おじさんの背伸びは変換しないであげる
              message.update!(convert_young_message: self.convert_young(message, word))
            elsif message.content.include?(word.conversion) && user.adult_flg == true  # おじさんが発信したら若者言葉に変換。若者の優しさは変換しない
                message.update!(convert_old_message: self.convert_old(message, word))
            end
        end
    end

    def convert_young(message,word)
        message.convert_young_message.gsub!(word.term, word.conversion)
    end

    def convert_old(message,word)
        message.convert_old_message.gsub!(word.conversion, word.term)
    end


end
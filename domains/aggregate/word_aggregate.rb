Dir['./domain/value_object/word/*.rb'].sort.each { |file| require file }


class WordAggregate

    def term(value)
        term,err = Term.new(value)
        if err.nil?
            term
        else
            value
        end
    end

    def convert(value)
        convert,err = Conversion.new(value)
        puts err
        if err.nil?
            convert
        else
            value
        end
    end

   
end
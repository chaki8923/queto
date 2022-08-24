
module Validate
    def validates(params,&block)
        schema = Dry::Schema.Params(&block)

        validate = schema.call(params)
        return validate.errors.to_h if validate.failure?
    end
end

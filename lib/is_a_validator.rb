class IsAValidator < ActiveModel::EachValidator
  def initialize(options)
    options[:class] = options[:class].to_s.camelize if options[:class].is_a?(Symbol)
    super(options)
  end
  def validate_each(record, attribute, value)
    cl = options[:class]
    # must do it during validation, because at definition time the
    # class might not be loaded yet (example: it's a STI subclass
    # of the validating record's class)
    cl = cl.constantize if cl.is_a?(String)
    record.errors[attribute] << "must be a #{cl}" unless value.is_a?(cl)
  end
end


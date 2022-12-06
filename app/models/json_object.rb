class JsonObject
  def initialize(json_hash)
    json_hash.each do |key, value|
      instance_variable_set("@#{key}", value)
      self.class.__send__(:attr_accessor, "#{key}")
    end
  end
end

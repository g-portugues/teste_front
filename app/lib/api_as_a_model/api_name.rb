module ApiAsAModel
  class ApiName
    attr_reader :name, :class, :singular, :plural

    def initialize(class_model)
      @name = class_model.name
      @class = class_model
      @singular = singular_route_key
      @plural = class_model.name.split('::').last.downcase.pluralize
    end

    def singular_route_key
      ApiName.singular_route_key(self)
    end

    def self.singular_route_key(class_model)
      class_model.name.split('::').last.downcase
    end
  end
end

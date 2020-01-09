module ApiAsAModel
  class ApiModel < ApiAccess
    def initialize(*params)
      super(*params)
    end
    
    def self.create(params)
      self.new.call_post(params)
    end

    def self.update
      call_patch
    end

    def self.find(id)
      self.new.call_get(id)
    end

    def self.find_by(params)
      self.new.call_get(nil, params)
    end

    def self.all
      teste = self.new
      teste.call_get
    end
  end
end

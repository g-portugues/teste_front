module Publicable
    extend ActiveSupport::Concern
  
    included do
      before_create :set_public_id
    end
  
    private
  
    def set_public_id
      self.public_id = SecureRandom.hex(4)
    end
  end
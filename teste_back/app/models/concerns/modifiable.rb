module Modifiable
  extend ActiveSupport::Concern

  included do
    before_validation :upcase_fields, :downcase_fields

    class_attribute :fields_for_upcase, :fields_for_downcase
  end

  class_methods do
    def upcase(*fields)
      self.fields_for_upcase = fields
    end

    def downcase(*fields)
      self.fields_for_downcase = fields
    end
  end

  private

  def upcase_fields
    return unless self.fields_for_upcase
    self.fields_for_upcase.each do |field|
      attr = read_attribute(field)
      if attr && attr.is_a?(String)
        write_attribute(
          field,
          attr.upcase
        )
      end
    end
  end

  def downcase_fields
    return unless self.fields_for_downcase
    self.fields_for_downcase.each do |field|
      attr = read_attribute(field)
      if attr && attr.is_a?(String)
        write_attribute(
          field,
          attr.downcase
        )
      end
    end
  end
end
module Rockstar
  class Metro < Base
    
    attr_accessor :name, :country

    class << self
      def new_from_xml(xml, doc)
        Metro.new(
          (xml).at(:name).inner_html, 
          (xml).at(:country).inner_html
        )
      end
    end
    
    def initialize(name, country)
      raise ArgumentError, "Name is required" if name.blank?
      raise ArgumentError, "Country is required" if country.blank?
      @name = name
      @country = country
    end
    
  end
end




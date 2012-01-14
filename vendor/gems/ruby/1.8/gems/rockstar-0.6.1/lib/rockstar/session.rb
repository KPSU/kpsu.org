module Rockstar
  class Session < Base
    attr_accessor :username, :key, :subscriber

    class << self
      def new_from_xml(xml, doc=nil)
        t       = Session.new()
        t.username  = (xml).at(:name).inner_html
        t.key   = (xml).at(:key).inner_html
        t.subscriber   = (xml).at(:subscriber).inner_html
        t
      end
    end
  end
end





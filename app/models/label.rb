class Label < ActiveRecord::Base
  has_many :albums
  
  def label_autocomplete
    @name = self.name
    "#{@name} #{self.id}"
  end
end

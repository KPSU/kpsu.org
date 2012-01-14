class Ability < ActiveRecord::Base

  has_and_belongs_to_many :roles
  
  def hashtag_address
      if self.ajax == true
        @ha = ":address/#{self.url}"
        return @ha
      else
        @ha = ""
        return @ha
      end
  end
  
end

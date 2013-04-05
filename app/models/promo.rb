class Promo < ActiveRecord::Base

	attr_accessible :title, :category, :count, :promomp3

	validates_presence_of :title
	validates_uniqueness_of :title

	mount_uploader :promomp3, Promomp3Uploader

	validates_presence_of :promomp3


	#default_value_for :url => "/system/files/promo.mp3"

  if ::Rails.env == "development"
    @url = "/uploads/promo/:id/:basename.:extension"
  else
    @url = "/uploads/promo/:id/:basename.:extension"
  end

  has_attached_file :promo_mp3,
                    :url => @url,
                    :path => ":rails_root/public/uploads/promo/:id/:basename.:extension",
                    :default_url => "/files/default-promo.mp3"

end

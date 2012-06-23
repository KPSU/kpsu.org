class ErrorsController < ApplicationController
  layout 'alternative'
  def routing
   render :template => "site/four_oh_four", :status => 404
  end
end
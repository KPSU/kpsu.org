class DjApplicationsController < ApplicationController
    layout 'alternative'

    def new
        #id is needed to deal with form
        @application = DjApplication.new(:id => 1)
    end

    def create
        @application = DjApplication.new(params[:dj_application])
        if @application.save
            flash[:alert] = "message sent"
            redirect_to('/', :notice => "Application was successfully sent.")
        else
            flash[:alert] = "You must fill all fields."
            render 'new'
        end
    end  
end

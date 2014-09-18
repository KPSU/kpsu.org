class AppsController < ApplicationController
    layout 'alternative'
    def new
        @applicant = App.new(:id => 1)
    end

    def create
        @applicant = App.new(params[:app])
        if @applicant.save
            redirect_to('/', :notice => "Application was successfully sent.")
        else
            flash[:alert] = "you must fill all fields."
            render 'new'
        end
    end
end

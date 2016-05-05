module Api
  class RacesController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        if !request.accept || request.accept == "*/*"
            render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
        else
        end
     end

    def show
        if !request.accept || request.accept == "*/*"
            render plain: "/api/races/#{params[:id]}"
        else
            @race = Race.find(params[:id])
            render "show", status: :ok
        end
    end

    def create
        if !request.accept || request.accept =="*/*"
            render plain: "#{params[:race][:name]}", status: :ok
        else
            puts "hi"
            race=Race.create(race_params)
            race.save
            render plain: race.name, status: :created
        end
    end

    def update
        race=Race.find(params[:id])
        race.update(race_params)
        render race
    end

    def destroy
        Race.find(params[:id]).destroy
        render :nothing=>true, :status => :no_content
    end
    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
        if !request.accept || request.accept =="*/*"
           render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
        else
            render :status=>:not_found, :template=>"api/error_msg", :locals=>{ :msg=>"woops: cannot find race[#{params[:id]}]"}
        end
    end

    private
        def race_params
            params.require(:race).permit(:name, :date)

        end
  end
end


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
        end
    end

    def create
        if !request.accept || request.accept =="*/*"
            render plain: :nothing, status: :ok
        else
        end
    end
  end
end


class BrandsController < ApplicationController
    
    def index
      @brands = Brand.all.includes(:posts)
    end
    
    def show
      @brand = Brand.find_by_id(params[:id])
    end

    def new
    end
end

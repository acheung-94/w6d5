class CatsController < ApplicationController

    def index
        @cats = Cat.all
        render :index
    end

    def create
        @cat = Cat.new(cat_params)
        if @cat.save
            redirect_to cat_url(@cat.id)
        else
            render json: @cat.errors.full_messages, status: 422
        end
    end

    def new
        @cat = Cat.new
        render :new
    end

    def edit
        incoming_id = params[:id]
        @cat = Cat.find_by(id: incoming_id)
        render :edit
    end

    def show
        incoming_id = params[:id]
        @cat = Cat.find_by(id: incoming_id)
        if @cat
            render :show
        else
            render json: "Cat not found!"
        end
    end

    def update
        incoming_id = params[:id]
        @cat = Cat.find_by(id: incoming_id)
        if @cat.update(cat_params)
            redirect_to cat_url(@cat.id)
        else
            render json: @cat.errors.full_messages, status: 422
        end
    end

    private
    def cat_params
        params.require(:cats).permit(:name, :birth_date, :color, :sex, :description)
    end

end

class KittensController < ApplicationController
    def index
        @kittens = Kitten.all

        respond_to do |format|
            format.html
            format.json { render json: @kittens }
        end
    end
    
    def new
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.new(kitten_params)

        if @kitten.save
            flash[:notice] = "Kitten successfully created!"
            redirect_to @kitten
        else
            flash[:alert] = "An error occurred."
            render 'new'
        end
    end

    def show
        @kitten = Kitten.find_by(:id => params[:id])

        respond_to do |format|
            format.html
            format.json { render json: @kitten }
        end
    end

    def edit
        @kitten = Kitten.find_by(:id => params[:id])
    end

    def update
        @kitten = Kitten.find_by(:id => params[:id])

        if @kitten.update(kitten_params)
            flash[:notice] = "Kitten successfully updated!"
            redirect_to @kitten
        else
            flash[:alert] = "An error occurred."
            render 'edit'
        end
    end

    def destroy
        @kitten = Kitten.find_by(:id => params[:id])
        @kitten.destroy
        flash[:notice] = "Kitten successfully deleted!"
        redirect_to root_path
    end

    private

      def kitten_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softness)
      end
end

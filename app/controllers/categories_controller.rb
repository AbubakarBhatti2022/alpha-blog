class CategoriesController < ApplicationController

    def new 
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category was Successfully Created"
            redirect_to @category
            
        else
            render 'new'
        end
    end

    def Index

    end

    def show

    end


    private

    def category_params

        params.require(:category).permit(:name)

    end

    
end


class CategoriesController < ApplicationController

    before_action :require_admin, except: [:index, :show]

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

      def index
        @categories = Category.paginate(page: params[:page], per_page: 8)
      end

    def show
@category = Category.find(params[:id])
    end


    private

    def category_params

        params.require(:category).permit(:name)

    end

    def require_admin
        if !(logged_in? && current_user.admin?)
          flash[:error] = "You must be an admin to access this page."
          redirect_to root_path
        end
    end

    
end


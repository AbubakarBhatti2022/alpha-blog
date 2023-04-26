class UsersController < ApplicationController
   

    before_action :set_user, only: [:show, :edit, :update]
    
    def show 
        @articles = @user.articles.paginate(page: params[:page], per_page: 4)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 6)
    end
    
    def new
@user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
        flash[:notice] = "Your Account was successfuly Updated"
        redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome To The Alpha Blog, #{@user.username} You Have Successfully SignUp"
            redirect_to users_path
            else
                render 'new'

        end
    end

private 
def user_params
    params.require(:user).permit(:username, :email, :password, :image )
end

def set_user
    @user = User.find(params[:id])

end

  end
  
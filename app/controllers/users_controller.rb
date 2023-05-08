class UsersController < ApplicationController
   

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def show 
        @articles = @user.articles.paginate(page: params[:page], per_page: 4)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 6)

        respond_to do |format|
            format.html
            format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
          end
    end
    
    def download_csv
        @users = User.all
        respond_to do |format|
          format.csv do
            send_data @users.to_csv, 
              filename: "users-#{Time.now.strftime('%Y-%m-%d_%H:%M')}.csv", 
              type: 'text/csv; charset=utf-8'
          end
        end
      end

    def new
@user = User.new
    end

    def edit
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Account and all Associated articles successfuly delete"
        redirect_to root_path
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


def require_same_user
    if current_user != @user && !current_user.admin?
        flash[:alert] = "You can only Edit and Update your own Account"
        redirect_to @user
    end
end

  end
  
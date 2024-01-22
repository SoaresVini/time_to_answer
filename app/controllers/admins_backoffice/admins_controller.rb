class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :varify_password, only: [:update]
  before_action :set_admin, only: [:update,:edit]
  #Usar o before_action quando uma ação depende do metodo e assim vc n precisa chamar o metodo na propria ação 

  def index
    @admins = Admin.all
  end

  def edit 

  end

  def update
    params_admin
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Admin atualizado com sucesso!"
    else
      render :edit
    end
  end

  private
  
  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin 
    @admin = Admin.find(params[:id])
  end

  def varify_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank? 
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
end



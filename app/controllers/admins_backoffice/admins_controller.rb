class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :varify_password, only: [:update]
  before_action :set_admin, only: [:update,:edit,:destroy]
  #Usar o before_action quando uma ação depende do metodo e assim vc n precisa chamar o metodo na propria ação 

  def index
    @admins = Admin.all .page params[:page]
    end
   

  def new 
    @admin = Admin.new
  end

  def edit 

  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save()
      redirect_to admins_backoffice_admins_path, notice: "Admin cadstrado com sucesso!"
    else
      render :new
    end
  end

  def update
    params_admin
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Admin atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Admin excluido com sucesso!"
    else
      render :index
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



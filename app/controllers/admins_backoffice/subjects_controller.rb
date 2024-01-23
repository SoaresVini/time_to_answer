class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subjets, only: [:update,:edit,:destroy]
  #Usar o before_action quando uma ação depende do metodo e assim vc n precisa chamar o metodo na propria ação 

  def index
    @subjects = Subject.all.order(:description).page(params[:page])
    end
   

  def new 
    @subject = Subject.new
  end

  def edit 

  end

  def create
    @subject = Subject.new(params_subject)
    if @subject.save()
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área cadstrado com sucesso!"
    else
      render :new
    end
  end

  def update
    params_subject
    if @subject.update(params_subject)
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_question_path, notice: "Assunto/Área 
        excluída com sucesso!"
      else
        render :index
      end
    end

  private
  
  def params_subject
    params.require(:subject).permit(:description)
  end

  def set_subjets 
    @subject = Subject.find(params[:id])
  end
end

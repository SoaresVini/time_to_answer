namespace :dev do
  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do 
    if Rails.env.development?
      show_spinner("Apagando BD") { %x(rails db:drop) }
      show_spinner("Criando BD") { %x(rails db:create) }
      show_spinner("Migrando DB") { %x(rails db:migrate) }
      show_spinner("Cadastrando User Padrão") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando Admin Padrão") { %x(rails dev:add_default_admin)  }
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  desc "Adicinando o admin Padrão"
  task add_default_admin: :environment do 
    Admin.create!(
      email: "admin@teste.com.br", 
      password: 123456, 
      password_confirmation: 123456
    )
  end

  desc "Adicinando o user Padrão"
  task add_default_user: :environment do 
    User.create!(
      email: "user@teste.com.br", 
      password: 123456, 
      password_confirmation: 123456
    )
  end

private 

  def show_spinner(msg_start, msg_end = "Sucesso!!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})......")
  end
end

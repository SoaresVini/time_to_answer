namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do 
    if Rails.env.development?
      show_spinner("Apagando BD") { %x(rails db:drop) }
      show_spinner("Criando BD") { %x(rails db:create) }
      show_spinner("Migrando DB") { %x(rails db:migrate) }
      show_spinner("Cadastrando User Padrão") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando Admin Padrão") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando Admins Extras") { %x(rails dev:add_extra_admins) }
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  desc "Adicinando o admin Padrão"
  task add_default_admin: :environment do 
    Admin.create!(
      email: "admin@teste.com.br", 
      password: DEFAULT_PASSWORD, 
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adicinando o admins extras"
  task add_extra_admins: :environment do 
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email, 
        password: DEFAULT_PASSWORD, 
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adicinando o user Padrão"
  task add_default_user: :environment do 
    User.create!(
      email: "user@teste.com.br", 
      password: DEFAULT_PASSWORD, 
      password_confirmation: DEFAULT_PASSWORD
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

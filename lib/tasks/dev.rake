namespace :dev do

DEFAULT_PASSWORD = 123456
DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

desc "Configurando o ambiente de desenvolvimento"
task setup: :environment do 
  if Rails.env.development?
    show_spinner("Apagando BD") { %x(rails db:drop) }
    show_spinner("Criando BD") { %x(rails db:create) }
    show_spinner("Migrando DB") { %x(rails db:migrate) }
    show_spinner("Cadastrando User Padrão") { %x(rails dev:add_default_user) }
    show_spinner("Cadastrando Admin Padrão") { %x(rails dev:add_default_admin) }
    show_spinner("Cadastrando Admins Extras") { %x(rails dev:add_extra_admins) }
    show_spinner("Cadastrando assuntos padrões...") { %x(rails dev:add_subjects) }
    show_spinner("Cadastrando perguntas e respostas...") { %x(rails dev:add_answers_and_questions) }
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

desc "Adicionando Subjects padrões"
task add_subjects: :environment do 
  file_name = 'subjects.txt'
  file_path = File.join(DEFAULT_FILES_PATH, file_name)

  File.open(file_path, 'r').each do |line|
    Subject.create!(description: line.strip)
  end
end

desc "Adicionando perguntas e respostas"
task add_answers_and_questions: :environment do 
  Subject.all.each do |subject|
    rand(5...10).times do |i|
      Question.create!(
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject
      )
    end
  end
end

private 

def show_spinner(msg_start, msg_end = "Sucesso!!")
  spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
  spinner.auto_spin
  yield
  spinner.success("(#{msg_end})......")
end
end

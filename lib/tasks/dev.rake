namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts "Resetando o BD"
    
    # %x(rails db:drop db:create db:migrate)

    puts "Cadastrando os tipos de contatos"
    
    kinds = %w(Amigo Comercial Conhecido).map do |kind|
      Kind.create!(description: kind)
    end

    puts "Tipos de contatos cadastrados com sucesso"

    puts "Cadastrando os contatos"
    
    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind_id: kinds.sample.id # Use kind_id para associar o contato a um tipo
      )
    end

    puts "Contatos cadastrados com sucesso"


    puts "Cadastrando os telefones"
    
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        contact.phones.create!(number: Faker::PhoneNumber.cell_phone)  
      end
    end

    puts "Telefones cadastrados com sucesso"

    puts "Cadastrando os endereços"
    
    Contact.all.each do |contact|
        address = Address.create(
          street: Faker::Address.street_address,
          city: Faker::Address.city,
          contact: contact
        )  
    end

    puts "Endereços cadastrados com sucesso"
  end
end

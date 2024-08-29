require 'rails_helper'

class Hash
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo,key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

describe ContactsController, type: :controller do
  context '#index' do
    it 'request index and return 4069(without accept)' do
      get :index
      expect(response).to have_http_status :not_acceptable
    end

    it 'request index and return 200' do
      request.accept = 'application/vnd.api+json'
      get :index
      expect(response).to have_http_status :ok
    end
  end
  # context "#show" do
  #   it 'GET /contacts/:id' do
      
  #     kind = Kind.create!(description: "Amigo")
  #     contact = Contact.create!(name: "Eduardo", email: "eduardo@essig.com", kind_id: kind.id)

  #     request.accept = 'application/vnd.api+json'
  #     get :show, params: {id: contact.id }
  #     expect(response).to have_http_status :ok  
  #     response_body = JSON.parse(response.body)
      
  #     response_body.json('data > id')

  #     expect(response_body.fetch('data > id')).to eq(contact.id.to_s)
  #     expect(response_body.fetch('data > type')).to eq('contacts') 
  #     expect(response_body.fetch('data > attributes > name')).to eq(contact.name) 
  #    end
  # end
end
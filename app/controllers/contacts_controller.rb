class ContactsController < ApplicationController
  include ErrorSerializer

  before_action :set_contact, only: %i[ show update destroy ]

  def index
    @contacts = Contact.all.page(params[:page].try(:[], :number))
    # paginate json: @contacts
    render json: @contacts
       
  end

  # GET /contacts/1
  def show
    render json: @contact #, include: [ :kind , :address, :phones]#, meta: { author: "Eduardo Essig" }
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, include: [:kind , :phones, :address], status: :created, location: @contact
    else
      render json: ErrorSerializer.serialize(@contact.errors)
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact, include: [:kind, :phones, :address]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      # params.require(:contact).permit(
      # :name, :email, :birthdate, :kind_id, 
      # phones_attributes: [:id , :number], 
      # address_attributes: [:id, :street, :city ])
      
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end

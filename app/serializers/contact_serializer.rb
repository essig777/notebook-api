class ContactSerializer < ActiveModel::Serializer
  attributes :id, 
    :name,
    :email,
    :birthdate
    #:author

  belongs_to :kind do
    link( :related ) { contact_kind_url(object.id) }
  end

  has_many :phones do
    link( :related) { contact_phones_url(object.id) }
  end

  has_one :address do
    link( :related) { contact_address_url(object.id) }
  end
  
  # link(:self) { contact_url(object.id) }
  # link(:kind) { kind_url(object.kind.id) }

  # def author
  #   "Eduardo Essig"  
  # end
  
  meta do 
    { author: "Eduardo Essig" }
  end

  def attributes(*args)
    h = super(*args)
    h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h
  end
end

class Address < ApplicationRecord
  # optional: true =>não importa o que o banco fale, o optional true/false que vai definir
  belongs_to :contact, optional: true
end

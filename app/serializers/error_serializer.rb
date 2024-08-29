module ErrorSerializer
  def self.serialize(errors)
    return if errors.nil?

    json = {}
    
    # Criar um array de hashes com os erros
    error_array = errors.to_hash.map do |k, v|
      v.map do |msg|
        { id: k, title: msg }
      end
    end.flatten
    
    # Atribuir o array de erros à chave :errors
    json[:errors] = error_array
    json
  end
end

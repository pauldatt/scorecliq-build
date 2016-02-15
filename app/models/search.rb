class Search 
    include ActiveModel::Validations
    attr_accessor :search
    
    validates :search, presence: true
end
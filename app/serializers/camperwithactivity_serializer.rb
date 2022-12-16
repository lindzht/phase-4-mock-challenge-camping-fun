class CamperwithactivitySerializer < ActiveModel::Serializer
  has_many :activities
  
  attributes :id, :name, :age



end

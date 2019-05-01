class REST::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role
end

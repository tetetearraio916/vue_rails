class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :token

  def token
    instance_options[:token] if instance_options[:token]
  end

end

module Mutations
  class CreateUser < BaseMutation
    field :user, Types::UserType, null: false

    argument :name, String, required: true
    argument :email, String, required: false

    def resolve(**arguments)
      user = User.create!(arguments)
      { user: user }
    end
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
  end
end

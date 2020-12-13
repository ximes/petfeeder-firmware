defmodule ApiWeb.Schema do
  use Absinthe.Schema
  alias ApiWeb.Resolvers.PetFeeder

  query do
    @desc "Get state"

    field :tray, :string do
      resolve &PetFeeder.tray/3
    end
  end

  mutation do
    field :release, type: :tray do
      arg :tray, non_null(:string)

      resolve &PetFeeder.release/3
    end
  end

  object :tray do
    field :id, non_null(:string)
  end
end

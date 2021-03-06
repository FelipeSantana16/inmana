defmodule Inmana.Restaurant do
  # Aqui nós importamos o schema e o changeset. O schema é como se fosse uma struct
  # mas é utilizado pra BD
  # Já o changeset é um agrupamento de dados a serem mandados para o BD
  use Ecto.Schema
  import Ecto.Changeset

  alias Inmana.Supply

  # Configuramos a primary_key pra ter um id binario e ser gerado automaticamente
  @primary_key {:id, :binary_id, autogenerate: true}

  # Criamos um tipo de variavel geral do modulo
  @required_params [:email, :name]

  # Esse @derive diz ao Json Encoder como quais campos e como codificalos para Json
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  # Aqui definimos a tabela do nosso restaurante com os devidos campos
  schema "restaurants" do
    field :email, :string
    field :name, :string

    # Criamos a relacao de restaurant com supply
    has_many :supplies, Supply

    # Pelo que entendi, essa função já traz alguns dados como "quando foi modificado"
    timestamps()
  end

  # Esse é o changeset sendo configurado
  def changeset(params) do
    # Dizemos que o que está sendo feito, usa o modulo atual(tipo um self?)
    %__MODULE__{}
    # Fazemos o cast dos parametros recebidos para email e nome
    |> cast(params, @required_params)
    # Dizemos que esses dados são obrigatórios
    |> validate_required(@required_params)
    # Dizemos que o email tem que ter no mínimo dois caracteres
    |> validate_length(:name, min: 2)
    # Dizemos que o email deve ter o @, ~r serve para definir um regex
    |> validate_format(:email, ~r/@/)
    # Dizemos que o email deve ser único
    |> unique_constraint([:email])
  end
end

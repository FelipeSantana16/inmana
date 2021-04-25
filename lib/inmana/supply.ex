defmodule Inmana.Supply do
  # Aqui nós importamos o schema e o changeset. O schema é como se fosse uma struct
  # mas é utilizado pra BD
  # Já o changeset é um agrupamento de dados a serem mandados para o BD
  use Ecto.Schema
  import Ecto.Changeset

  alias Inmana.Restaurant
  # Configuramos a primary_key pra ter um id binario e ser gerado automaticamente
  @primary_key {:id, :binary_id, autogenerate: true}

  # Criamos um tipo de variavel geral do modulo
  @required_params [:description, :expiration_date, :responsible, :restaurant_id]

  # Esse @derive diz ao Json Encoder como quais campos e como codificalos para Json
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  # Aqui definimos a tabela do nosso restaurante com os devidos campos
  schema "supplies" do
    field :description, :string
    field :expiration_date, :date
    field :responsible, :string

    # Definimos aqui o relacionamento de supply com restaurat
    belongs_to :restaurant, Restaurant

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
    # Dizemos que a description tem que ter no mínimo dois caracteres
    |> validate_length(:description, min: 3)
    # Dizemos que o responsavel tem que ter no mínimo dois caracteres
    |> validate_length(:responsible, min: 3)
  end
end

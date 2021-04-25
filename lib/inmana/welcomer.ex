defmodule Inmana.Welcomer do
  # Receber um nome e uma idade do usuário
  # Se o usuário se chamar "banana" e tiver idade "42", ele recebe uma mensagem especial
  # Se o usuário for maior de idade, ele recebe uma mensagem normal
  # Se o usuário for menor de idade, retornamos um erro
  # Temos que tratar o nome do usuário para entradas erradas, como "BaNaNa", "BaNaNa  \n"

  def welcome(%{"name" => name, "age" => age}) do
    age = String.to_integer(age)

    name
    # Retiramos espaços e possíveis quebras de linhas ou outros modificados como \t \n
    |> String.trim()
    # Deixamos a String em minúsculo
    |> String.downcase()
    # Fazemos uma validacao a partir da idade. Obs.: Podemos omitir o nome como parametro
    |> evaluate(age)
  end

  # Nesse formato de validacao entregamos uma resposta sobre a conexao que pode ser ok ou error e uma mensagem
  # Essa resposta é passada para a controller
  defp evaluate("banana", 42) do
    {:ok, "You are very special, banana"}
  end

  defp evaluate(name, age) when age >= 18 do
    {:ok, "Welcome #{name}"}
  end

  defp evaluate(name, _age) do
    {:error, "You shall not pass #{name}"}
  end
end

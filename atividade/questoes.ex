defmodule Atividade do
  # Questão 1
  def exibir_ola_mundo do
    IO.puts "Olá Mundo!"
  end

  # Questão 2
  def exibir_nome do
    IO.puts "Agora, digite seu nome: "
    nome = IO.gets("") |> String.trim()
    IO.puts "Olá #{nome}!"
  end

  # Questão 3
  def exibir_nome_e_idade do
    IO.puts "Digite seu nome: "
    nome = IO.gets("") |> String.trim

    IO.puts "Digite sua data de nascimento no formato DD MM AAAA: "
    data_nascimento_str = IO.gets("") |> String.trim()
    [dia_str, mes_str, ano_str] = String.split(data_nascimento_str, ~r/\s+/)

    {dia, mes, ano} =
      {String.to_integer(dia_str), String.to_integer(mes_str), String.to_integer(ano_str)}

    idade = Date.utc_today().year() - ano

    IO.puts "Olá #{nome}, você tem #{idade} anos."
  end

  # Questão 4
  def exibir_nome_peso_e_altura do
    IO.puts "Digite seu nome: "
    nome = IO.gets("") |> String.trim

    IO.puts "Digite seu peso em Kg (apenas números positivos): "
    peso_kg = obter_peso_valido()

    IO.puts "Digite sua altura em centímetros (no formato 1,70 cm): "
    altura_cm = obter_altura_valida()

    altura_m = altura_cm / 100.0
    imc = calcular_imc(peso_kg, altura_m)

    IO.puts "Olá #{nome}, seu IMC é de #{imc}."
  end

  defp obter_peso_valido do
    case String.trim(IO.gets("")) |> String.to_float() do
      nil ->
        IO.puts "Peso inválido. Digite novamente."
        obter_peso_valido()
      peso when peso >= 0 -> peso
       _ ->
        IO.puts "Peso negativo. Digite novamente."
        obter_peso_valido()
      end
  end

  defp obter_altura_valida do
    case String.trim(IO.gets("")) do
      ~r/^\d,\d{2}\s*cm$/ -> String.to_float(String.replace(~r/,/, ".", trim_leading: true))
      _ ->
        IO.puts "Altura inválida. Digite novamente no formato 1,70 cm."
        obter_altura_valida()
    end
  end

  defp calcular_imc(peso, altura) do
    peso / (altura * altura)
  end


end

Atividade.exibir_ola_mundo()
Atividade.exibir_nome()
Atividade.exibir_nome_e_idade()
Atividade.exibir_nome_peso_e_altura()

# Questões 7 e 8
defmodule SistemaPoligono do
  defstruct pontos: %{}

  def principal do
    loop(%SistemaPoligono{})
  end

  defp loop(sistema) do
    IO.puts "
    Sistema Final
    =============
    1. Criar
    2. Listar
    3. Atualizar
    4. Excluir
    5. Translação
    6. Escala
    7. Rotação
    8. Reflexão
    9. Sair
    \n"

    IO.write "Entre com sua opção: "
    opcao = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    case opcao do
      1 -> loop(criar(sistema))
      2 -> loop(listar(sistema))
      3 -> loop(atualizar(sistema))
      4 -> loop(excluir(sistema))
      5 -> loop(translacao(sistema))
      6 -> loop(escala(sistema))
      7 -> loop(rotacao(sistema))
      8 -> loop(reflexao(sistema))
      9 -> :ok
      _ -> loop(sistema)
    end
  end

  defp criar(sistema) do
    IO.puts "Função Criar"

    IO.write "Digite a coordenada x e y (exemplo: 1 5): "
    input = IO.gets(" |> ") |> String.trim()

    [x_str, y_str] = String.split(input, " ")

    x = String.to_integer(x_str)
    y = String.to_integer(y_str)

    IO.puts "Coordenada x: #{x}, Coordenada y: #{y}"

    novo_ponto = {Map.size(sistema.pontos) + 1, [x, y]}
    sistema = %SistemaPoligono{pontos: Map.put(sistema.pontos, Map.size(sistema.pontos) + 1, novo_ponto)}

    loop(sistema)
  end

  defp listar(sistema) do
    IO.puts "Função Listar"
    Enum.each(sistema.pontos, fn {k, v} -> IO.puts "#{k}: #{inspect(v)}" end)
    loop(sistema)
  end

  defp atualizar(sistema) do
    IO.puts "Função Atualizar"
    IO.write "Digite o número do ponto a ser atualizado: "
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    case Map.get(sistema.pontos, numero) do
      nil ->
        IO.puts "Ponto não encontrado."
        loop(sistema)

      ponto ->
        IO.puts "Ponto atual: #{inspect(ponto)}"
        IO.write "Digite a nova coordenada x: "
        x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

        IO.write "Digite a nova coordenada y: "
        y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

        novo_ponto = [x, y]
        sistema = %SistemaPoligono{pontos: Map.put(sistema.pontos, numero, novo_ponto)}
        loop(sistema)
    end
  end

  defp excluir(sistema) do
    IO.puts "Função Excluir"
    IO.write "Digite o número do ponto a ser excluído: "
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    sistema = %SistemaPoligono{pontos: Map.delete(sistema.pontos, numero)}
    loop(sistema)
  end

  defp translacao(sistema) do
    IO.puts "Função Translação"
    IO.write "Digite a quantidade de translação em x: "
    delta_x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    IO.write "Digite a quantidade de translação em y: "
    delta_y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    sistema = %SistemaPoligono{pontos: Map.transform_values(sistema.pontos, &transladar_ponto(&1, delta_x, delta_y))}
    loop(sistema)
  end

  defp escala(sistema) do
    IO.puts "Função Escala"
    IO.write "Digite o fator de escala em x: "
    fator_x = IO.gets(" |> ") |> String.trim() |> String.to_float()

    IO.write "Digite o fator de escala em y: "
    fator_y = IO.gets(" |> ") |> String.trim() |> String.to_float()

    sistema = %SistemaPoligono{pontos: Map.transform_values(sistema.pontos, &escalar_ponto(&1, fator_x, fator_y))}
    loop(sistema)
  end

  defp rotacao(sistema) do
    IO.puts "Função Rotação"
    IO.write "Digite o ângulo de rotação em graus: "
    angulo = IO.gets(" |> ") |> String.trim() |> String.to_float()

    sistema = %SistemaPoligono{pontos: Map.transform_values(sistema.pontos, &rotacionar_ponto(&1, angulo))}
    loop(sistema)
  end

  defp reflexao(sistema) do
    IO.puts "Função Reflexão"
    IO.puts "1. Reflexão Horizontal"
    IO.puts "2. Reflexão Vertical"
    IO.write "Escolha a opção de reflexão: "
    opcao = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    sistema =
      case opcao do
        1 -> %SistemaPoligono{pontos: Map.transform_values(sistema.pontos, &refletir_horizontalmente(&1))}
        2 -> %SistemaPoligono{pontos: Map.transform_values(sistema.pontos, &refletir_verticalmente(&1))}
        _ -> sistema
      end

    loop(sistema)
  end


  defp transladar_ponto([x, y], delta_x, delta_y), do: [x + delta_x, y + delta_y]

  defp escalar_ponto([x, y], fator_x, fator_y), do: [x * fator_x, y * fator_y]

  defp rotacionar_ponto([x, y], angulo) do
    angulo_rad = :math.radians(angulo)
    x_rotacionado = x * :math.cos(angulo_rad) - y * :math.sin(angulo_rad)
    y_rotacionado = x * :math.sin(angulo_rad) + y * :math.cos(angulo_rad)
    [x_rotacionado, y_rotacionado]
  end

  defp refletir_horizontalmente([x, y]), do: [-x, y]

  defp refletir_verticalmente([x, y]), do: [x, -y]
end

SistemaPoligono.principal()

defmodule SistemaCRUD do
  defstruct x: 0, y: 0

  def principal do
    menu(%{pontos: %{}, estado: nil})
  end

  def menu(estado) do
    IO.puts("Sistema Final")
    IO.puts("=============")
    IO.puts("1. Criar ponto")
    IO.puts("2. Listar pontos")
    IO.puts("3. Atualizar ponto")
    IO.puts("4. Excluir ponto")
    IO.puts("5. Translação")
    IO.puts("6. Escala")
    IO.puts("7. Rotação")
    IO.puts("8. Reflexão")
    IO.puts("9. Sair")
    IO.puts("Entre com sua opção:")

    opcao =
      IO.gets(" |> ")
      |> String.trim()
      |> String.to_integer()

    case opcao do
      1 -> criar_ponto(estado)
      2 -> listar_pontos(estado)
      3 -> atualizar_ponto(estado)
      4 -> excluir_ponto(estado)
      5 -> translacao(estado)
      6 -> escala(estado)
      7 -> rotacao(estado)
      8 -> reflexao(estado)
    end
  end

  def criar_ponto(estado) do
    IO.puts("Função para criar um ponto")
    IO.puts("Digite o número do ponto:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    IO.puts("Digite a coordenada x:")
    x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    IO.puts("Digite a coordenada y:")
    y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = %SistemaCRUD{x: x, y: y}
    pontos = Map.put(estado.pontos, numero, ponto)

    IO.puts("Ponto criado com sucesso!")
    menu(%{estado | pontos: pontos})
  end

  def listar_pontos(estado) do
    IO.puts("Função para listar os pontos")

    pontos = estado.pontos

    Enum.each(Map.to_list(pontos), fn {numero, ponto} ->
      IO.puts("Ponto #{numero}: x = #{ponto.x}, y = #{ponto.y}")
    end)

    menu(estado)
  end

  def atualizar_ponto(estado) do
    IO.puts("Função para atualizar o ponto determinado")
    IO.puts("Digite o número do ponto a ser atualizado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite a nova coordenada x:")
      x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite a nova coordenada y:")
      y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      novo_ponto = %SistemaCRUD{x: x, y: y}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Ponto atualizado com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def excluir_ponto(estado) do
    IO.puts("Função Excluir Ponto")
    IO.puts("Digite o número do ponto a ser excluído:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    pontos_atualizados = Map.delete(estado.pontos, numero)

    IO.puts("Ponto excluído com sucesso!")
    menu(%{estado | pontos: pontos_atualizados})
  end

  def translacao(estado) do
    IO.puts("Função Translação")
    IO.puts("Digite o número do ponto a ser transladado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite o fator de translação em x:")
      tx = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite o fator de translação em y:")
      ty = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      novo_ponto = %SistemaCRUD{x: ponto.x + tx, y: ponto.y + ty}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Translação realizada com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def escala(estado) do
    IO.puts("Função Escala")
    IO.puts("Digite o número do ponto a ser escalado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite o fator de escala em x:")
      sx_input = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite o fator de escala em y:")
      sy_input = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      novo_ponto = %SistemaCRUD{x: ponto.x * sx_input, y: ponto.y * sy_input}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Escala realizada com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def rotacao(estado) do
    IO.puts("Função Rotação")
    IO.puts("Digite o número do ponto a ser rotacionado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite o ângulo de rotação em graus:")
      angulo_input = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      radianos = :math.pi() * angulo_input / 180.0
      {cos_theta, sin_theta} = {:math.cos(radianos), :math.sin(radianos)}

      novo_x = ponto.x * cos_theta - ponto.y * sin_theta
      novo_y = ponto.x * sin_theta + ponto.y * cos_theta

      novo_ponto = %SistemaCRUD{x: novo_x, y: novo_y}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Rotação realizada com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def reflexao(estado) do
    IO.puts("Função Reflexão")
    IO.puts("Digite o número do ponto a ser refletido:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Escolha o eixo de reflexão (Digite "1" ou "2"):")
      IO.puts("1. Eixo X")
      IO.puts("2. Eixo Y")

      escolha_eixo =
        IO.gets(" |> ")
        |> String.trim()
        |> String.to_integer()

      novo_ponto =
        case escolha_eixo do
          1 -> %SistemaCRUD{x: ponto.x, y: -ponto.y}
          2 -> %SistemaCRUD{x: -ponto.x, y: ponto.y}
          _ ->
            IO.puts("Escolha de eixo inválida.")
            menu(estado)
        end

      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Reflexão realizada com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

end

# Inicie o sistema chamando a função principal
SistemaCRUD.principal()

CÓDIGO FINAL MSM:

Mostrar texto das mensagens anteriores
    IO.puts("Função para atualizar o ponto")
    IO.puts("Digite o número do ponto a ser atualizado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite a nova coordenada x:")
      x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite a nova coordenada y:")
      y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      novo_ponto = %SistemaCRUD{x: x, y: y}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Ponto atualizado com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def excluir_ponto(estado) do
    IO.puts("Função para excluir o ponto")
    IO.puts("Digite o número do ponto a ser excluído:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    pontos_atualizados = Map.delete(estado.pontos, numero)

    IO.puts("Ponto excluído com sucesso!")
    menu(%{estado | pontos: pontos_atualizados})
  end

  def translacao(estado) do
    IO.puts("Função para realizar a translação")
    IO.puts("Digite o número do ponto a ser transladado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite o fator de translação em x:")
      tx = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite o fator de translação em y:")
      ty = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      novo_ponto = %SistemaCRUD{x: ponto.x + tx, y: ponto.y + ty}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Translação realizada com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def escala(estado) do
    IO.puts("Função para realizar a escala")
    IO.puts("Digite o número do ponto a ser escalado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite o fator de escala em x:")
      sx_input = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite o fator de escala em y:")
      sy_input = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      novo_ponto = %SistemaCRUD{x: ponto.x * sx_input, y: ponto.y * sy_input}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Escala realizada com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def rotacao(estado) do
    IO.puts("Função para realizar a rotação")
    IO.puts("Digite o número do ponto a ser rotacionado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(estado.pontos, numero)

    if ponto do
      IO.puts("Digite o ângulo de rotação em graus:")
      angulo_input = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      radianos = :math.pi() * angulo_input / 180.0
      {cos_theta, sin_theta} = {:math.cos(radianos), :math.sin(radianos)}

      novo_x = ponto.x * cos_theta - ponto.y * sin_theta
      novo_y = ponto.x * sin_theta + ponto.y * cos_theta

      novo_ponto = %SistemaCRUD{x: novo_x, y: novo_y}
      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Rotação realizada com sucesso!")
      menu(%{estado | pontos: pontos_atualizados})
    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end
  end

  def reflexao(estado) do

    IO.puts("Função Reflexão")

    IO.puts("Digite o número do ponto a ser refletido:")

    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()


    ponto = Map.get(estado.pontos, numero)


    if ponto do
      IO.puts("Escolha o eixo de reflexão (Digite 1 ou 2):")
      IO.puts("1. Eixo X")
      IO.puts("2. Eixo Y")

      escolha_eixo = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      case escolha_eixo do
        1 -> novo_ponto = %SistemaCRUD{x: ponto.x, y: -ponto.y}

        2 -> novo_ponto = %SistemaCRUD{x: -ponto.x, y: ponto.y}

        _ -> IO.puts("Escolha de eixo inválida.")

          menu(estado)
      end

      pontos_atualizados = Map.put(estado.pontos, numero, novo_ponto)

      IO.puts("Reflexão realizada com sucesso!")

      menu(%{estado | pontos: pontos_atualizados})

    else
      IO.puts("Ponto não encontrado.")
      menu(estado)
    end

  end



SistemaCRUD.principal()



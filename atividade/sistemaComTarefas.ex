defmodule SistemaComTarefas do

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
    IO.puts("Entre com sua opção:")

    opcao = IO.gets(" |> ")|> String.trim()|> String.to_integer()


    case opcao do
      1 -> criar_ponto(estado)
      2 -> listar_pontos(estado)
      3 -> atualizar_ponto(estado)
      4 -> excluir_ponto(estado)

  defmodule Operacoes do
    def criar() do
      IO.puts "Executando a função Criar em uma tarefa..."

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

    def listar() do
      IO.puts "Executando a função Listar em uma tarefa..."
      IO.puts("Função para listar os pontos")


    pontos = estado.pontos


    Enum.each(Map.to_list(pontos), fn {numero, ponto} ->

      IO.puts("Ponto #{numero}: x = #{ponto.x}, y = #{ponto.y}")

    end)


    menu(estado)


    end

    def atualizar() do
      IO.puts "Executando a função Atualizar em uma tarefa..."
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

    def excluir() do
      IO.puts "Executando a função Excluir em uma tarefa..."
      IO.puts("Função Excluir Ponto")

    IO.puts("Digite o número do ponto a ser excluído:")

    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()


    pontos_atualizados = Map.delete(estado.pontos, numero)


    IO.puts("Ponto excluído com sucesso!")

    menu(%{estado | pontos: pontos_atualizados})
    end
  end

  def principal() do
    IO.puts "Sistema com Tarefas"
    IO.puts "==================="

    task_criar = Task.async(fn -> Operacoes.criar() end)
    task_listar = Task.async(fn -> Operacoes.listar() end)
    task_atualizar = Task.async(fn -> Operacoes.atualizar() end)
    task_excluir = Task.async(fn -> Operacoes.excluir() end)

    Task.await(task_criar)
    Task.await(task_listar)
    Task.await(task_atualizar)
    Task.await(task_excluir)

    IO.puts "Todas as tarefas concluídas."
  end
end

SistemaComTarefas.principal()
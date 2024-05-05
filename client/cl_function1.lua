-- Este é um arquivo Lua contendo um conjunto de funções para interações e feedbacks em um jogo.

-- Define uma tabela chamada Functions para armazenar todas as funções relacionadas.
Functions = {}

-- Função para exibir uma notificação no jogo.
-- Parâmetros:
--   pesan (string): A mensagem a ser exibida na notificação.
--   type (string): O tipo de notificação (opcional).
--   durasi (number): A duração da notificação em milissegundos (opcional).
-- Retorna:
--   Nada.
Functions.notify = function(pesan, type, durasi)
    -- Chama o evento 'mn:shownotif' para exibir a notificação com os parâmetros fornecidos.
    TriggerEvent('mn:shownotif', pesan, type, durasi)
end

-- Função para desenhar texto na tela do jogo.
-- Parâmetros:
--   pesan (string): A mensagem de texto a ser exibida.
--   icon (string): O ícone opcional a ser exibido junto com o texto (padrão é vazio).
-- Retorna:
--   Nada.
Functions.drawtext = function(pesan, icon)
    -- Usa a função lib.showTextUI para exibir o texto na tela com a posição, ícone e estilo especificados.
    lib.showTextUI(pesan, {
        position = "left-center",
        icon = icon or '',  -- Usa o ícone fornecido ou uma string vazia se nenhum ícone for fornecido.
        style = {
            borderRadius = 3,
            backgroundColor = '#028cf5',
            color = 'white'
        }
    })
end

-- Função para ocultar o texto desenhado na tela do jogo.
-- Parâmetros:
--   Nenhum.
-- Retorna:
--   Nada.
Functions.hidetext = function()
    -- Chama a função lib.hideTextUI para ocultar o texto da tela.
    lib.hideTextUI()
end

-- Função para verificar se o jogador possui um determinado item em seu inventário.
-- Parâmetros:
--   namaItem (string): O nome do item a ser verificado.
--   Jumlah (number): A quantidade mínima do item desejada (opcional, padrão é 0).
-- Retorna:
--   true se o jogador possuir pelo menos a quantidade mínima do item, false caso contrário.
Functions.HasItem = function(namaItem, Jumlah)
    -- Verifica se o nome do item foi fornecido.
    if not namaItem then 
        return error('Nome do item precisa ser fornecido') -- Retorna um erro se o nome do item estiver ausente.
    end
    
    Jumlah = Jumlah or 0 -- Define a quantidade mínima como 0 se não for fornecida.
    
    -- Retorna true se o jogador possuir pelo menos a quantidade mínima do item, usando a função de busca no inventário.
    return exports.ox_inventory:Search('count', namaItem) >= Jumlah
end

-- Função para criar uma barra de progresso na tela do jogo.
-- Parâmetros:
--   label (string): O rótulo da barra de progresso.
--   durasi (number): A duração da barra de progresso em milissegundos.
--   anim (boolean): Uma flag indicando se a animação está habilitada.
--   prop (string): A propriedade opcional para a barra de progresso.
--   onFinish (function): A função de retorno de chamada quando a barra de progresso for concluída.
--   onCancel (function): A função de retorno de chamada quando a barra de progresso for cancelada.
-- Retorna:
--   Nada.
Functions.progressbar = function(label, durasi, anim, prop, onFinish, onCancel)
    -- Cria a barra de progresso com os parâmetros fornecidos.
    if lib.progressBar({
        duration = durasi,
        label = label,
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true
        },
        anim = anim,
        prop = prop
    }) then
        onFinish()  -- Chama a função de retorno de chamada onFinish se a barra de progresso for concluída.
    else
        onCancel()  -- Chama a função de retorno de chamada onCancel se a barra de progresso for cancelada.
    end
end

-- Define uma variável global para armazenar o ped do centro de emprego.
local jobcenterped = nil

-- Função principal que cria os blips e peds do centro de emprego.
CreateThread(function()
    -- Verifica se a configuração para usar o centro de emprego está ativada.
    if Config.pakaijob then
        -- Loop sobre a tabela de locais e informações do centro de emprego da configuração.
        for k, v in pairs(Config.ambilPekerjaan) do
            -- Adiciona um blip para o local do centro de emprego.
            local blip = AddBlipForCoord(v.lokasi.xyz)
            SetBlipSprite (blip, 407)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 1.2)
            SetBlipColour (blip, 27)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(locale('jobcenter_blipname'))
            EndTextCommandSetBlipName(blip)
            
            -- Verifica se o modelo do ped do centro de emprego pode ser carregado.
            if lib.requestModel(v.pedmodel, 1500) then
                -- Cria o ped do centro de emprego.
                jobcenterped = CreatePed(1, v.pedmodel, v.lokasi.xy, v.lokasi.z - 1, v.lokasi.w, false, false)
                SetPedFleeAttributes(jobcenterped, 0, 0)
                SetPedDropsWeaponsWhenDead(jobcenterped, false)
                SetPedDiesWhenInjured(jobcenterped, false)
                SetEntityInvincible(jobcenterped , true)
                FreezeEntityPosition(jobcenterped, true)
                SetBlockingOfNonTemporaryEvents(jobcenterped, true)
            end

            -- Adiciona um target local para interagir com o ped do centro de emprego.
            exports.ox_target:addLocalEntity(jobcenterped, {
                {
                    label = locale('jobcenter_labeltarget'),  -- Rótulo do target.
                    icon = 'fas fa-clipboard',               -- Ícone do target.
                    onSelect = function ()                    -- Função de retorno de chamada quando selecionado.
                        -- Alterna o estado do jogador entre trabalhando e não trabalhando.
                        local statuskerja = LocalPlayer.state.pekerja or false
                        LocalPlayer.state:set('pekerja', not statuskerja, not statuskerja)
                        -- Exibe uma notificação informando se o jogador começou ou parou de trabalhar.
                        Functions.notify(LocalPlayer.state.pekerja and locale('jobcenter_mulaibekerja') or locale('jobcenter_berhentikerja'))
                    end,
                    distance = 1.5  -- Distância de interação com o target.
                }
            })
        end
    end
end)

-- Evento que é acionado quando um jogador é carregado.
RegisterNetEvent('esx:playerLoaded', function( )
    -- Define o estado do jogador como não trabalhando.
    LocalPlayer.state:set('pekerja', false, true)
end)

-- Evento acionado quando o jogador é carregado.
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    -- Define o estado do jogador como não trabalhando.
    LocalPlayer.state:set('pekerja', false, true)
end)

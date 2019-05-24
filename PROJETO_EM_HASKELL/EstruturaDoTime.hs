module EstruturaDoTime where
-- estrutura de dados reponsavel por amazenar um time
data Time = Time {
 nome      :: String,
 ataque    :: Int,
 defesa    :: Int,
 controle  :: Int,
 confianca :: Int,
 condicao  :: Int
} deriving (Show)

--  exemplo de funcao de como seria para atualizar atributo do time
atualizaAtaque :: Time -> Int -> Time
atualizaAtaque time valor = Time {
 nome = nome time,
 ataque = valor,
 defesa = defesa time,
 controle = controle time,
 condicao = condicao time, 
 confianca = confianca time
}

atualizaDefesa :: Time -> Int -> Time
atualizaDefesa time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = valor,
 controle = controle time,
 condicao = condicao time, 
 confianca = confianca time
}

atualizaControle :: Time -> Int -> Time
atualizaControle time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = valor,
 condicao = condicao time, 
 confianca = confianca time
}

atualizacondicao :: Time -> Int -> Time
atualizacondicao time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = controle time,
 condicao = valor, 
 confianca = confianca time
}

atualizaConfianca :: Time -> Int -> Time
atualizaConfianca time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = controle time,
 condicao = condicao time, 
 confianca = valor
}

-- seleciona e reponsavel por atualizar o valor do capital de apostas 
seleciona :: String -> IO(Int)
seleciona opcao   
 | opcao == "s" = do
  putStrLn "digite o capital adicional"
  entrada <- readLn ::IO Int
  return entrada
 | otherwise = return 0



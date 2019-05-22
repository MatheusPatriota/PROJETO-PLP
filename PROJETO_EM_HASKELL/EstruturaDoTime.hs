module EstruturaDoTime where
-- estrutura de dados reponsavel por amazenar um time
data Time = Time {
 nome :: String,
 ataque :: Int,
 defesa :: Int,
 controle :: Int,
 disposicaoFisica :: Int,
 confianca :: Int,
 adefinir :: Int
} deriving (Show)

--  exemplo de funcao de como seria para atualizar atributo do time
atualizaAtaque :: Time -> Int -> Time
atualizaAtaque time valor = Time {
 nome = nome time,
 ataque = valor,
 defesa = defesa time,
 controle = controle time,
 disposicaoFisica = disposicaoFisica time, 
 confianca = confianca time,
 adefinir = adefinir time
}

atualizaDefesa :: Time -> Int -> Time
atualizaDefesa time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = valor,
 controle = controle time,
 disposicaoFisica = disposicaoFisica time, 
 confianca = confianca time,
 adefinir = adefinir time
}

atualizaControle :: Time -> Int -> Time
atualizaControle time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = valor,
 disposicaoFisica = disposicaoFisica time, 
 confianca = confianca time,
 adefinir = adefinir time
}

atualizaDisposicaoFisica :: Time -> Int -> Time
atualizaDisposicaoFisica time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = controle time,
 disposicaoFisica = valor, 
 confianca = confianca time,
 adefinir = adefinir time
}

atualizaConfianca :: Time -> Int -> Time
atualizaConfianca time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = controle time,
 disposicaoFisica = disposicaoFisica time, 
 confianca = valor,
 adefinir = adefinir time
}

atualizaADefinir :: Time -> Int -> Time
atualizaADefinir time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = controle time,
 disposicaoFisica = disposicaoFisica time, 
 confianca = confianca time,
 adefinir = valor
}

-- seleciona e reponsavel por atualizar o valor do capital de apostas 
seleciona :: String -> IO(Int)
seleciona opcao   
 | opcao == "s" = do
  putStrLn "digite o capital adicional"
  entrada <- readLn ::IO Int
  return entrada
 | otherwise = return 0



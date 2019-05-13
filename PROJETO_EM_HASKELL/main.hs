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
atualizaAtributo :: Time -> Int -> Time
atualizaAtributo time valor = Time {
 nome = nome time,
 ataque = ataque time,
 defesa = defesa time,
 controle = controle time,
 disposicaoFisica = disposicaoFisica time, 
 confianca = confianca time,
 adefinir = valor
}

-- seleciona e reponsavel por atualizar o valor do capital de apostas 
seleciona :: String -> Int -> Int
seleciona opcao valor  
 | opcao == "s" = valor + 2000
 | otherwise = 2000

-- main fazendo a chamada e os prints
main :: IO()
main = do

 let campinense = Time "Campinense"  77 72 77 76 100 80
 let treze = Time "Treze"  73 70 74 72 100 80
 let botafogo = Time "Botafogo" 80 76 81 78 100 80
 let souza = Time "Souza"  63 65 65 68 100 80
 let nacionalDePatos = Time "Nacional de Patos"  59 60 0 61 100 80
 let serrano = Time "Serrano" 48 50 56 52  100 80
 let atleticoPB = Time "Atletico-PB"  58 61 62 59 100 80
 let perilima = Time "Perilima"  46 50 59 46 100 80
 let esporteDePatos = Time "Esporte de Patos" 57 62 61 57 100 80
 let csp = Time "CSP"  64 66 69 65 100 80
 


 putStrLn "Esses são os Times que disputarão o Campeonato Paraibano: "
 putStrLn (nome campinense ++ ", " ++ nome treze ++ ", " ++ nome botafogo ++ ", " ++ nome souza ++ ", " ++ nome nacionalDePatos ++ ", " ++ nome serrano ++ ", " ++ nome atleticoPB ++ ", " ++ nome perilima ++ ", " ++ nome esporteDePatos ++ ", " ++ nome csp)


 putStrLn ""
 putStrLn "Deseja aumentar o capital das apostas? (s/n) "
 opcao <- getLine
 valor <- readLn :: IO Int
 let capital = seleciona opcao valor

 putStr "Seu capital inicial será de: " 
 print capital

 print (atualizaAtributo campinense 90)


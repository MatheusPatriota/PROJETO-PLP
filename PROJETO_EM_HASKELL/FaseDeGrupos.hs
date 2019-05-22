module FaseDeGrupos where

import System.Random
import Data.List

main :: IO()

-- Funcoes de calculo de gols de um jogo de dois times
toInt :: Float -> Int
toInt x = round x

somatorio :: Time -> Int
somatorio timeT = (ataque timeT) + (defesa timeT) + (controle timeT) + (confianca timeT) + (condicao timeT)

auxCalculoDeForca :: Int -> Int
auxCalculoDeForca x = toInt(((fromIntegral x) * 0.7)  * 0.01)

calculoDeForca :: Time -> Time -> (Int, Int)
calculoDeForca timeA timeB = do
    let x = auxCalculoDeForca (somatorio timeA)
    let y = auxCalculoDeForca (somatorio timeB)
    (x, y)
-- Fim das funcoes de calculo de gols

-- Metodo que cria um lista de tamanho N com numero aleatorios entre 0 e 9
randomList :: Int -> IO([Int])
randomList 0 = return []
randomList n = do
  r  <- randomRIO (0,9)
  rs <- randomList (n-1)
  return (r:rs) 

-- Estrutura de um time
data Time = Time {
 nome      :: String,
 ataque    :: Int,
 defesa    :: Int,
 controle  :: Int,
 confianca :: Int,
 condicao  :: Int
} deriving (Show)

-- Estrutura de um time em um grupo
data TimeDeGrupo = TimeDeGrupo {
 time     :: Time,
 pontos   :: Int,
 jogos    :: Int,
 vitorias :: Int,
 empates  :: Int,
 derrotas :: Int,
 gols     :: Int
} deriving (Show)

-- Estrutura do grupoA
data GrupoA = GrupoA {
 time1 :: TimeDeGrupo,
 time2 :: TimeDeGrupo,
 time3 :: TimeDeGrupo,
 time4 :: TimeDeGrupo,
 time5 :: TimeDeGrupo
} deriving (Show)

-- Estrutur do grupoB
data GrupoB = GrupoB {
 time6  :: TimeDeGrupo,
 time7  :: TimeDeGrupo,
 time8  :: TimeDeGrupo,
 time9  :: TimeDeGrupo,
 time10 :: TimeDeGrupo
} deriving (Show)

-- Funcao para padronizar o tamanho de strings
validaString :: String -> Int -> String
validaString texto tamanho 
 | (length texto) < tamanho = (validaString (texto ++ " ") tamanho)
 | otherwise = texto

-- Funcao para imprimir bunitinho um time de um grupo
imprimeTime :: TimeDeGrupo -> Int -> String
imprimeTime timeX pos = (show pos) ++ "º  " ++ (validaString (nome (time timeX)) 20) ++ "       " ++ (validaString (show (pontos timeX)) 2) ++ "          " ++ (validaString (show (jogos timeX)) 2) ++ "           " ++ (validaString (show (vitorias timeX)) 2) ++ "              " ++ (validaString (show (empates timeX)) 2) ++ "              " ++ (validaString (show (derrotas timeX)) 2) ++ "            " ++ (validaString (show (gols timeX)) 2)

-- Funcao pra imprimir um grupo bem bunitinho com ajuda do metodo anterior
imprimeGrupoA :: GrupoA -> String
imprimeGrupoA grupo = (imprimeTime (time1 grupo) 1) ++ "\n"  ++ (imprimeTime (time2 grupo) 2) ++ "\n" ++ (imprimeTime (time3 grupo) 3) ++ "\n" ++ (imprimeTime (time4 grupo) 4) ++ "\n" ++ (imprimeTime (time5 grupo) 5)

-- Funcao pra imprimir um grupo bem bunitinho com ajuda do metodo anterior
imprimeGrupoB :: GrupoB -> String
imprimeGrupoB grupo = (imprimeTime (time6 grupo) 1) ++ "\n"  ++ (imprimeTime (time7 grupo) 2) ++ "\n" ++ (imprimeTime (time8 grupo) 3) ++ "\n" ++ (imprimeTime (time9 grupo) 4) ++ "\n" ++ (imprimeTime (time10 grupo) 5)

-- Funcao que compara dos times apartir primeiramente dos pontos e em caso de forem iguais compara os gols
ordenaGrupo primeiroTime segundoTime
 | (pontos primeiroTime) > (pontos segundoTime) = GT
 | (pontos primeiroTime) < (pontos segundoTime) = LT
 | otherwise = compare (gols primeiroTime) (gols segundoTime)

-- Metodo que realiza um jogo entre dois times
realizaJogos :: TimeDeGrupo -> TimeDeGrupo -> ( ( (String, TimeDeGrupo), TimeDeGrupo), (Int, Int) )
realizaJogos timeX timeY 
 | golsX > golsY = ( ((( (nome (time timeX)) ++ " x " ++ (nome (time timeY)) ) , timeX), timeY) , (golsX, golsY))
 | golsX < golsY = ( ((( (nome (time timeX)) ++ " x " ++ (nome (time timeY)) ) , timeY), timeX) , (golsY, golsX))
 | otherwise =     ( ((( (nome (time timeX)) ++ " x " ++ (nome (time timeY)) ) , timeX ), timeY ) , (golsX, golsY))
 where gols = calculoDeForca (time timeX) (time timeY)
       golsX = fst gols
       golsY = snd gols

-- Funcao para atualizar os pontos de um time de grupo
att_Pontos :: TimeDeGrupo -> Int -> TimeDeGrupo
att_Pontos timeX valor = TimeDeGrupo {
  time     = time timeX,
  pontos   = ((pontos timeX) + valor),
  jogos    = jogos timeX,
  vitorias = vitorias timeX,
  empates  = empates timeX,
  derrotas = derrotas timeX,
  gols     = gols timeX
}   

-- Funcao para atualizar os jogos de um time de grupo
att_Jogos :: TimeDeGrupo -> Int -> TimeDeGrupo
att_Jogos timeX valor = TimeDeGrupo {
  time     = time timeX,
  pontos   = pontos timeX,
  jogos    = ((jogos timeX) + valor),
  vitorias = vitorias timeX,
  empates  = empates timeX,
  derrotas = derrotas timeX,
  gols     = gols timeX
}

-- Funcao para atualizar os vitorias de um time de grupo
att_Vitorias :: TimeDeGrupo -> Int -> TimeDeGrupo
att_Vitorias timeX valor = TimeDeGrupo {
  time     = time timeX,
  pontos   = pontos timeX,
  jogos    = jogos timeX,
  vitorias = ((vitorias timeX) + valor),
  empates  = empates timeX,
  derrotas = derrotas timeX,
  gols     = gols timeX
}

-- Funcao para atualizar os empates de um time de grupo
att_Empates :: TimeDeGrupo -> Int -> TimeDeGrupo
att_Empates timeX valor = TimeDeGrupo {
  time     = time timeX,
  pontos   = pontos timeX,
  jogos    = jogos timeX,
  vitorias = vitorias timeX,
  empates  = ((empates timeX) + valor),
  derrotas = derrotas timeX,
  gols     = gols timeX
}

-- Funcao para atualizar os derrotas de um time de grupo
att_Derrotas :: TimeDeGrupo -> Int -> TimeDeGrupo
att_Derrotas timeX valor = TimeDeGrupo {
  time     = time timeX,
  pontos   = pontos timeX,
  jogos    = jogos timeX,
  vitorias = vitorias timeX,
  empates  = empates timeX,
  derrotas = ((derrotas timeX) + valor),
  gols     = gols timeX
}

-- Funcao para atualizar os gols de um time de grupo
att_Gols :: TimeDeGrupo -> Int -> TimeDeGrupo
att_Gols timeX valor = TimeDeGrupo {
  time     = time timeX,
  pontos   = pontos timeX,
  jogos    = jogos timeX,
  vitorias = vitorias timeX,
  empates  = empates timeX,
  derrotas = derrotas timeX,
  gols     = ((gols timeX) + valor)
}

-- Atualiza os metodos de um time que ganhou
atualizaTimeVencedor :: TimeDeGrupo -> Int -> TimeDeGrupo
atualizaTimeVencedor timeV golsV = TimeDeGrupo {
  time     = time timeV,
  pontos   = (pontos timeV) + 3,
  jogos    = (jogos timeV) + 1,
  vitorias = (vitorias timeV) + 1,
  empates  = empates timeV,
  derrotas = derrotas timeV,
  gols     = (gols timeV) + golsV
 }

-- Atualiza os atributos de um time que perdeu
atualizaTimePerdedor :: TimeDeGrupo -> Int -> TimeDeGrupo
atualizaTimePerdedor timeP golsP = TimeDeGrupo {
  time     = time timeP,
  pontos   = pontos timeP,
  jogos    = (jogos timeP) + 1,
  vitorias = vitorias timeP,
  empates  = empates timeP,
  derrotas = (derrotas timeP) + 1,
  gols     = (gols timeP) + golsP
 }
 
-- Atualiza os atributos de um time que empatou
atualizaTimeEmpate :: TimeDeGrupo -> Int -> TimeDeGrupo
atualizaTimeEmpate timeP golsP = TimeDeGrupo {
  time     = time timeP,
  pontos   = (pontos timeP) + 1,
  jogos    = (jogos timeP) + 1,
  vitorias = vitorias timeP,
  empates  = (empates timeP) + 1,
  derrotas = derrotas timeP,
  gols     = (gols timeP) + golsP
 }

-- Funcao que verifica o que aconteceu em um jogo (vitoria de algum time ou empate) apartir dos gols
verificaResultado :: (Int, Int) -> TimeDeGrupo -> TimeDeGrupo -> TimeDeGrupo -> TimeDeGrupo -> (TimeDeGrupo, TimeDeGrupo)
verificaResultado tupla w x y z
 | (fst tupla) == (snd tupla) = (y, z)
 | otherwise = (w, x)

-- Metodo que atualiza um time no grupoA (se ele existir no grupo)
atualizaGrupoA :: TimeDeGrupo -> [TimeDeGrupo] -> [TimeDeGrupo]
atualizaGrupoA timeX [] = []
atualizaGrupoA timeX (primeiro:resto)
 | (nome (time timeX)) == (nome (time primeiro)) = [timeX] ++ resto
 | otherwise = [primeiro] ++ atualizaGrupoA timeX resto

-- Metodo que atualiza um time no grupoB (se ele existir no grupo)
atualizaGrupoB :: TimeDeGrupo -> [TimeDeGrupo] -> [TimeDeGrupo]
atualizaGrupoB timeX [] = []
atualizaGrupoB timeX (primeiro:resto)
 | (nome (time timeX)) == (nome (time primeiro)) = [timeX] ++ resto
 | otherwise = [primeiro] ++ atualizaGrupoB timeX resto

-- Main de testes
main = do
 
 -- Time so pra deixar default na constante AUX
 let timeLuiggy = Time "LuiggyFC" 99 99 99 99 99
 let timeNULL   = TimeDeGrupo timeLuiggy 0 0 0 0 0 0
 let aux        = timeNULL
 let aux2 = 0;
 
 -- Criando times com seus atributos
 let campinense = Time "Campinense"        70 20 40 70 80
 let treze      = Time "Treze"             80 40 30 20 90
 let botafogo   = Time "Botafogo-PB"       90 90 10 40 70
 let atletico   = Time "Atletico-PB"       10 40 20 60 10
 let souza      = Time "Souza"             60 20 50 40 20
 let naciconal  = Time "Nacional de Patos" 40 40 80 80 40
 let serrano    = Time "Serrano"           90 80 70 90 60
 let perilima   = Time "Perilima"          20 60 60 70 50
 let esporte    = Time "Esporte de Patos"  70 30 40 20 70
 let csp        = Time "CSP"               50 80 50 30 40
 
 -- Criando times de grupo com seus atributos
 let time1  = TimeDeGrupo campinense 0 0 0 0 0 0
 let time2  = TimeDeGrupo treze      0 0 0 0 0 0
 let time3  = TimeDeGrupo botafogo   0 0 0 0 0 0
 let time4  = TimeDeGrupo atletico   0 0 0 0 0 0
 let time5  = TimeDeGrupo souza      0 0 0 0 0 0
 let time6  = TimeDeGrupo naciconal  0 0 0 0 0 0 
 let time7  = TimeDeGrupo serrano    0 0 0 0 0 0 
 let time8  = TimeDeGrupo perilima   0 0 0 0 0 0
 let time9  = TimeDeGrupo esporte    0 0 0 0 0 0
 let time10 = TimeDeGrupo csp        0 0 0 0 0 0  
 
 -- Criando lista com os times e lista de indices com a nova ordem (aleatoria) dos times e colocando os times nos grupos
 let times = [time1, time2, time3, time4, time5, time6, time7, time8, time9, time10]
 io <- randomList 1000 :: IO [Int]
 let indices = (nub io)

 let timesDoGrupoA = [(times!!(indices!!0)), (times!!(indices!!1)), (times!!(indices!!2)), (times!!(indices!!3)), (times!!(indices!!4))]
 let timesDoGrupoB = [(times!!(indices!!5)), (times!!(indices!!6)), (times!!(indices!!7)), (times!!(indices!!8)), (times!!(indices!!9))]

 -- Criando o grupoA e grupoB com os times criados anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)


-- Rodada 1
-- Jogo 1
 let aux = (realizaJogos (timesDoGrupoA!!0) (timesDoGrupoB!!0)) 
 let jogo1 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 let vencedores = [(snd (fst (fst aux)))] -- Lista de times vencedores da rodada


 let novotimeV = atualizaTimeVencedor (snd (fst (fst aux))) (fst aux2) -- Atualizando o time vencedor
 let novotimeP = atualizaTimePerdedor (snd (fst aux)) (snd aux2)  -- Atualizando o time perdedor

 -- Atualizando os dois times se empataram
 let novotimeE1 = atualizaTimeEmpate (snd (fst (fst aux))) (fst aux2)
 let novotimeE2 = atualizaTimeEmpate (snd (fst aux)) (snd aux2)

 let novosTimes = verificaResultado aux2 novotimeV novotimeP novotimeE1 novotimeE2
 

 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (snd novosTimes) aux

-- Jogo 2
 let aux = (realizaJogos (timesDoGrupoA!!1) (timesDoGrupoB!!1)) 
 let jogo2 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 let vencedores = [(snd (fst (fst aux)))] -- Lista de times vencedores da rodada

 let novotimeV = atualizaTimeVencedor (snd (fst (fst aux))) (fst aux2) -- Atualizando o time vencedor
 let novotimeP = atualizaTimePerdedor (snd (fst aux)) (snd aux2)  -- Atualizando o time perdedor

 -- Atualizando os dois times se empataram
 let novotimeE1 = atualizaTimeEmpate (snd (fst (fst aux))) (fst aux2)
 let novotimeE2 = atualizaTimeEmpate (snd (fst aux)) (snd aux2)

 let novosTimes = verificaResultado aux2 novotimeV novotimeP novotimeE1 novotimeE2
 

 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (snd novosTimes) aux

 -- Jogo 3
 let aux = (realizaJogos (timesDoGrupoA!!2) (timesDoGrupoB!!2)) 
 let jogo3 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 let vencedores = [(snd (fst (fst aux)))] -- Lista de times vencedores da rodada

 let novotimeV = atualizaTimeVencedor (snd (fst (fst aux))) (fst aux2) -- Atualizando o time vencedor
 let novotimeP = atualizaTimePerdedor (snd (fst aux)) (snd aux2)  -- Atualizando o time perdedor

 -- Atualizando os dois times se empataram
 let novotimeE1 = atualizaTimeEmpate (snd (fst (fst aux))) (fst aux2)
 let novotimeE2 = atualizaTimeEmpate (snd (fst aux)) (snd aux2)

 let novosTimes = verificaResultado aux2 novotimeV novotimeP novotimeE1 novotimeE2
 

 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (snd novosTimes) aux

-- Jogo 4
 let aux = (realizaJogos (timesDoGrupoA!!3) (timesDoGrupoB!!3)) 
 let jogo4 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 let vencedores = [(snd (fst (fst aux)))] -- Lista de times vencedores da rodada

 let novotimeV = atualizaTimeVencedor (snd (fst (fst aux))) (fst aux2) -- Atualizando o time vencedor
 let novotimeP = atualizaTimePerdedor (snd (fst aux)) (snd aux2)  -- Atualizando o time perdedor

 -- Atualizando os dois times se empataram
 let novotimeE1 = atualizaTimeEmpate (snd (fst (fst aux))) (fst aux2)
 let novotimeE2 = atualizaTimeEmpate (snd (fst aux)) (snd aux2)

 let novosTimes = verificaResultado aux2 novotimeV novotimeP novotimeE1 novotimeE2
 

 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (snd novosTimes) aux

-- Jogo 5
 let aux = (realizaJogos (timesDoGrupoA!!4) (timesDoGrupoB!!4)) 
 let jogo5 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 let vencedores = [(snd (fst (fst aux)))] -- Lista de times vencedores da rodada

 let novotimeV = atualizaTimeVencedor (snd (fst (fst aux))) (fst aux2) -- Atualizando o time vencedor
 let novotimeP = atualizaTimePerdedor (snd (fst aux)) (snd aux2)  -- Atualizando o time perdedor

 -- Atualizando os dois times se empataram
 let novotimeE1 = atualizaTimeEmpate (snd (fst (fst aux))) (fst aux2)
 let novotimeE2 = atualizaTimeEmpate (snd (fst aux)) (snd aux2)

 let novosTimes = verificaResultado aux2 novotimeV novotimeP novotimeE1 novotimeE2
 

 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = atualizaGrupoA (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = atualizaGrupoB (snd novosTimes) aux


 print jogo1
 print jogo2
 print jogo3
 print jogo4
 print jogo5


 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn ""
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""














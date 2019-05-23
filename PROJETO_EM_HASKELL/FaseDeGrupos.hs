import System.Random
import Data.List
import System.IO.Unsafe

main :: IO()

-- Funcoes de calculo de gols de um jogo de dois times
toInt :: Float -> Int
toInt x = round x

somatorio :: Time -> Int
somatorio timeT = (ataque timeT) + (defesa timeT) + (controle timeT) + (confianca timeT) + (condicao timeT)

geraValorAleatorio :: Int -> Int
geraValorAleatorio x = x + unsafePerformIO (randomRIO (-x,x))

auxCalculoDeForca :: Int -> Int
auxCalculoDeForca x = geraValorAleatorio (toInt(((fromIntegral x) * 0.7)  * 0.01))

calculoDeForca :: Time -> Time -> (Int, Int)
calculoDeForca timeA timeB = do
    let x = auxCalculoDeForca (somatorio timeA)
    let y = auxCalculoDeForca (somatorio timeB)
    (x, y)
-- Fim das funcoes de calculo de gols


--Metodos responsáveis pelas apostas
vencedoresDaRodada :: [String] -> Int -> String -> Int
vencedoresDaRodada [] x y = (-500)
vencedoresDaRodada (p:px) x y 
    |p == y = (650)
    |otherwise = (vencedoresDaRodada px x y)


vencedores :: [String] -> Int -> [String] -> Int
vencedores (p:px) x [] = x
vencedores (p:px) x (c:cx) = (vencedores (p:px) x cx) + (vencedoresDaRodada (p:px) x c)

seleciona :: String -> Int
seleciona opcao  
 | opcao == "s" = 2000 + unsafePerformIO ( (readLn:: IO Int))
 | otherwise = 2000


verificaStringsVazias :: [String] -> [String]
verificaStringsVazias [] = []
verificaStringsVazias (p:px)
    |p == "" = verificaStringsVazias px
    |otherwise = [p] ++ verificaStringsVazias px
--Fim dos metodos responsáveis pelas apostas

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
atualizaGrupoB timeY [] = []
atualizaGrupoB timeY (primeiro:resto)
 | (nome (time timeY)) == (nome (time primeiro)) = [timeY] ++ resto
 | otherwise = [primeiro] ++ atualizaGrupoB timeY resto

-- Metodo que busca nos grupos apartir do seu nome e retorna o objeto completo
buscaTime :: String -> [TimeDeGrupo] -> [TimeDeGrupo] -> TimeDeGrupo
buscaTime timeX (primeiroA:restoA) (primeiroB:restoB) 
 | timeX == (nome (time primeiroA)) = primeiroA
 | timeX == (nome (time primeiroB)) = primeiroB
 | otherwise = buscaTime timeX restoA restoB  

-- Metodo que atualiza um time num grupo
setTime :: TimeDeGrupo -> [TimeDeGrupo] -> [TimeDeGrupo]
setTime t1 [] = []
setTime t1 (x:xs)
 | (nome (time t1)) == (nome (time x)) = [t1] ++ xs
 | otherwise = [x] ++ setTime t1 xs

-- Metodo que retorna os times classificados para semifinal do campeonato
getClassificadosSemifinal :: [TimeDeGrupo] -> [TimeDeGrupo] -> ((TimeDeGrupo, TimeDeGrupo), (TimeDeGrupo, TimeDeGrupo))
getClassificadosSemifinal grupoA grupoB = (((grupoA!!0),(grupoA!!1)),((grupoB!!0),(grupoB!!1)))

-- Metodo que adiciona um time a uma lista de times
addToList :: TimeDeGrupo -> TimeDeGrupo -> (Int,Int) -> [TimeDeGrupo] -> [TimeDeGrupo]
addToList time timeNulo gols lista 
 | (fst gols) /= (snd gols) = [time] ++ lista
 | otherwise = [timeNulo] ++ lista


-- Main de testes
main = do
 
 putStrLn "Bem Vindo ao simulador do Campeonato Paraibano de Futebol 2019"
 putStrLn ""
 putStrLn "Deseja aumentar o capital das apostas? (s/n) "
 opcao <- getLine

 let capital = seleciona opcao

 putStr "Seu capital inicial será de: " 
 print capital

 -- Time so pra deixar default na constante AUX
 let timeLuiggy = Time "LuiggyFC" 99 99 99 99 99
 let timeNULL   = TimeDeGrupo timeLuiggy 0 0 0 0 0 0
 let aux        = timeNULL
 let aux2 = 0;
 let auxVencedores = []
 let vencedoresRodada = []
 
 -- Criando times com seus atributos
 let campinense = Time "Campinense"        77 72 77 76 100
 let treze      = Time "Treze"             73 70 74 72 100
 let botafogo   = Time "Botafogo-PB"       80 76 81 78 100
 let atletico   = Time "Atletico-PB"       58 61 62 59 100
 let souza      = Time "Souza"             63 65 65 68 100
 let naciconal  = Time "Nacional de Patos" 59 60 45 61 100
 let serrano    = Time "Serrano"           48 50 56 52 100
 let perilima   = Time "Perilima"          46 50 59 46 100
 let esporte    = Time "Esporte de Patos"  57 62 61 57 100
 let csp        = Time "CSP"               64 66 69 65 100
 
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

 let t0 = (times!!(indices!!0))
 let t1 = (times!!(indices!!1))
 let t2 = (times!!(indices!!2))
 let t3 = (times!!(indices!!3))
 let t4 = (times!!(indices!!4))

 let t5 = (times!!(indices!!5))
 let t6 = (times!!(indices!!6))
 let t7 = (times!!(indices!!7))
 let t8 = (times!!(indices!!8))
 let t9 = (times!!(indices!!9))


 let timesDoGrupoA = [(times!!(indices!!0)), (times!!(indices!!1)), (times!!(indices!!2)), (times!!(indices!!3)), (times!!(indices!!4))]
 let timesDoGrupoB = [(times!!(indices!!5)), (times!!(indices!!6)), (times!!(indices!!7)), (times!!(indices!!8)), (times!!(indices!!9))]

 -- Criando o grupoA e grupoB com os times criados anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

-- Rodada 1
-- Jogo 1
 let aux = (realizaJogos (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB)) 
 let jogo1 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)

 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada


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
 let aux = (realizaJogos (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB))
 let jogo2 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB))
 let jogo3 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)

 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB))
 let jogo4 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)

 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB))
 let jogo5 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux


 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 putStrLn "Partidas Rodada 01:"
 print jogo1
 print jogo2
 print jogo3
 print jogo4
 print jogo5
 putStrLn  ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "----------------------------------------------- Rodada 01 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""

 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a primeira Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 1

-- Rodada 2
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB))
 let jogo6 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB)) 
 let jogo7 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB))
 let jogo8 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB)) 
 let jogo9 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB))
 let jogo10 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 putStrLn "Partidas Rodada 02:"
 print jogo6
 print jogo7
 print jogo8
 print jogo9
 print jogo10
 putStrLn ""

 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "----------------------------------------------- Rodada 02 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""

 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Segunda Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 2

-- Rodada 3
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB))
 let jogo11 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB))
 let jogo12 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB)) 
 let jogo13 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB))
 let jogo14 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB)) 
 let jogo15 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux


 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 03:"
 print jogo11
 print jogo12
 print jogo13
 print jogo14
 print jogo15
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 03 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Terceira Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 3

-- Rodada 4
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB)) 
 let jogo16 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB)) 
 let jogo17 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB)) 
 let jogo18 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB))  
 let jogo19 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB))  
 let jogo20 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 04:"
 print jogo16
 print jogo17
 print jogo18
 print jogo19
 print jogo20
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 04 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Quarta Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 4


-- Rodada 5
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB))  
 let jogo21 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada


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
 let aux = (realizaJogos (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB))   
 let jogo22 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)

 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB))   
 let jogo23 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB))   
 let jogo24 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB))   
 let jogo25 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 05:"
 print jogo21
 print jogo22
 print jogo23
 print jogo24
 print jogo25
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 05 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Quinta Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 5


 -- Rodada 6
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB))  
 let jogo26 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)

 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada


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
 let aux = (realizaJogos (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB))   
 let jogo27 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB))   
 let jogo28 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB))   
 let jogo29 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB))   
 let jogo30 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 06:"
 print jogo26
 print jogo27
 print jogo28
 print jogo29
 print jogo30
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 06 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Sexta Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 6


 -- Rodada 7
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB))  
 let jogo31 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada


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
 let aux = (realizaJogos (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB))   
 let jogo32 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB))   
 let jogo33 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB))   
 let jogo34 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB))   
 let jogo35 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 07:"
 print jogo31
 print jogo32
 print jogo33
 print jogo34
 print jogo35
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 07 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Setima Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 7



 -- Rodada 8
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB))  
 let jogo36 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada


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
 let aux = (realizaJogos (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB))   
 let jogo37 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB))   
 let jogo38 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB))   
 let jogo39 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB))   
 let jogo40 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 08:"
 print jogo36
 print jogo37
 print jogo38
 print jogo39
 print jogo40
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 08 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Oitava Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 8



 -- Rodada 9
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB))  
 let jogo41 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada


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
 let aux = (realizaJogos (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB))   
 let jogo42 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB))   
 let jogo43 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB))   
 let jogo44 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB))   
 let jogo45 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 09:"
 print jogo41
 print jogo42
 print jogo43
 print jogo44
 print jogo45
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 09 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Nona Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 9



 -- Rodada 10
-- Jogo 1
 let vencedoresRodada = []
 let aux = (realizaJogos (buscaTime (nome (time t5)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t1)) timesDoGrupoA timesDoGrupoB))  
 let jogo46 = fst (fst (fst aux)) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada


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
 let aux = (realizaJogos (buscaTime (nome (time t6)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t2)) timesDoGrupoA timesDoGrupoB))   
 let jogo47 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t7)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t3)) timesDoGrupoA timesDoGrupoB))   
 let jogo48 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t8)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t4)) timesDoGrupoA timesDoGrupoB))   
 let jogo49 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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
 let aux = (realizaJogos (buscaTime (nome (time t9)) timesDoGrupoA timesDoGrupoB) (buscaTime (nome (time t0)) timesDoGrupoA timesDoGrupoB))   
 let jogo50 = (fst (fst (fst aux))) -- String com print do jogo "Time1 x Time2"
 let aux2 = snd aux -- Tupla de gols do jogo (golsTime1, golsTime2)
 
 let auxVencedores = vencedoresRodada
 let vencedoresRodada = addToList (snd (fst (fst aux))) timeNULL aux2 auxVencedores -- Lista de times vencedores da rodada

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

 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (fst novosTimes) aux
 let aux = timesDoGrupoA
 let timesDoGrupoA = setTime (snd novosTimes) aux

 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (fst novosTimes) aux
 let aux = timesDoGrupoB
 let timesDoGrupoB = setTime (snd novosTimes) aux

 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = reverse (sortBy ordenaGrupo aux)

 let aux = timesDoGrupoB
 let timesDoGrupoB = reverse (sortBy ordenaGrupo aux)

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!0) (timesDoGrupoB!!1) (timesDoGrupoB!!2) (timesDoGrupoB!!3) (timesDoGrupoB!!4)

 putStrLn "Partidas Rodada 10:"
 print jogo46
 print jogo47
 print jogo48
 print jogo49
 print jogo50
 putStrLn ""


 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter"
 putStrLn "" 
 time1 <- getLine
 let auxA = time1:[]

 putStrLn "" 
 print "O usuario gostaria de realizar a primeira aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Você apostou nos times: "
 print auxTimesApostados
 putStrLn ""

 putStrLn "----------------------------------------------- Rodada 10 -----------------------------------------------"
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
 -- Metodo para ajudar nas apostas
 putStrLn "Times vencedores da rodada: "
 putStrLn ((nome (time (vencedoresRodada!!0))) ++ " | " ++ (nome (time (vencedoresRodada!!1))) ++ " | " ++ (nome (time (vencedoresRodada!!2))) ++ " | " ++ (nome (time (vencedoresRodada!!3))) ++ " | " ++ (nome (time (vencedoresRodada!!4))))
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""

 let v1 = (nome (time (vencedoresRodada!!0)))
 let v2 = (nome (time (vencedoresRodada!!1)))
 let v3 = (nome (time (vencedoresRodada!!2)))
 let v4 = (nome (time (vencedoresRodada!!3)))
 let v5 = (nome (time (vencedoresRodada!!4)))

 let vTotal = [v1] ++ [v2] ++ [v3] ++ [v4] ++ [v5]

 let auxCapital = capital

 let capital = vencedores vTotal auxCapital auxTimesApostados
 

 print "Seu Capital Total após a Decima Rodada é de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 10
 
 let classificadosSemiFinal = getClassificadosSemifinal timesDoGrupoA timesDoGrupoB 
 putStrLn "Classificados para semifinal:"
 putStrLn ((nome (time (fst(fst classificadosSemiFinal)))) ++ " | " ++ (nome (time (snd(fst classificadosSemiFinal)))) ++ " | " ++ (nome (time (fst(snd classificadosSemiFinal)))) ++ " | " ++ (nome (time (snd(snd classificadosSemiFinal)))))

 putStr "Saldo total das Apostas está em: "
 print capital
import System.Random
import Data.List

main :: IO()

-- Funcoes de calculo de gols de um jogo de dois times
toInt :: Float -> Int
toInt x = round x

auxCalculoDeForca :: Int -> Int
auxCalculoDeForca x = toInt(((fromIntegral x) * 0.7)  * 0.01)

calculoDeForca :: Int -> Int -> (Int, Int)
calculoDeForca timeA timeB = do
    let x = auxCalculoDeForca timeA
    let y = auxCalculoDeForca timeB
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


ordenaGrupo primeiroTime segundoTime
 | (pontos primeiroTime) > (pontos segundoTime) = GT
 | (pontos primeiroTime) < (pontos segundoTime) = LT
 | otherwise = compare (gols primeiroTime) (gols segundoTime)

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

-- Main de testes
main = do
 
 -- Time so pra deixar default na constante AUX
 let timeLuiggy = Time "LuiggyFC" 99 99 99 99 99
 let timeNULL   = TimeDeGrupo timeLuiggy 0 0 0 0 0 0
 let aux        = timeNULL
 
 -- Criando times com seus atributos
 let campinense = Time "Campinense"        50 50 50 50 50
 let treze      = Time "Treze"             50 50 50 50 50
 let botafogo   = Time "Botafogo-PB"       50 50 50 50 50
 let atletico   = Time "Atletico-PB"       50 50 50 50 50
 let souza      = Time "Souza"             50 50 50 50 50
 let naciconal  = Time "Nacional de Patos" 50 50 50 50 50
 let serrano    = Time "Serrano"           50 50 50 50 50
 let perilima   = Time "Perilima"          50 50 50 50 50
 let esporte    = Time "Esporte de Patos"  50 50 50 50 50
 let csp        = Time "CSP"               50 50 50 50 50
 
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
 io <- randomList 100 :: IO [Int]
 let indices = (nub io)

 let timesDoGrupoA = [(times!!(indices!!0)), (times!!(indices!!1)), (times!!(indices!!2)), (times!!(indices!!3)), (times!!(indices!!4))]
 let timesDoGrupoB = [(times!!(indices!!5)), (times!!(indices!!6)), (times!!(indices!!7)), (times!!(indices!!8)), (times!!(indices!!9))]

 -- Criando o grupoA e grupoB com os times criados anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!5) (timesDoGrupoB!!6) (timesDoGrupoB!!7) (timesDoGrupoB!!8) (timesDoGrupoB!!9)
 
 -- Atualizando os pontos do time1
 let aux = time1
 let time1 = att_Pontos aux 50
 -- Atualizando os jogos do time1
 let aux = time1
 let time1 = att_Jogos aux 40
 -- Atualizando as vitorias do time1
 let aux = time1
 let time1 = att_Vitorias aux 10
 -- Atualizando os empates do time1
 let aux = time1
 let time1 = att_Empates aux 20
 -- Atualizando as derrotas do time1
 let aux = time1
 let time1 = att_Derrotas aux 10 
 -- Atualizando os gols do time1
 let aux = time1
 let time1 = att_Gols aux 10

 -- Atualizando o time na lista de times
 let times = [time1, time2, time3, time4, time5, time6, time7, time8, time9, time10]
 
 let timesDoGrupoA = [(times!!(indices!!0)), (times!!(indices!!1)), (times!!(indices!!2)), (times!!(indices!!3)), (times!!(indices!!4))]
 let timesDoGrupoB = [(times!!(indices!!5)), (times!!(indices!!6)), (times!!(indices!!7)), (times!!(indices!!8)), (times!!(indices!!9))]
 
 -- Ordenando o grupo pelos pontos de cada time
 let aux = timesDoGrupoA
 let timesDoGrupoA = sortBy ordenaGrupo aux

 -- Atualizando o time no grupo com as alteracoes feitas anteriormente
 let grupoA = GrupoA (timesDoGrupoA!!0) (timesDoGrupoA!!1) (timesDoGrupoA!!2) (timesDoGrupoA!!3) (timesDoGrupoA!!4)
 let grupoB = GrupoB (timesDoGrupoB!!5) (timesDoGrupoB!!6) (timesDoGrupoB!!7) (timesDoGrupoB!!8) (timesDoGrupoB!!9)

 putStrLn ""
 -- Imprimindo o grupo de um jeito bem bunitinho
 putStrLn "Classificação: GrupoA        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoA grupoA)
 putStrLn ""
 putStrLn "Classificação: GrupoB        Pontos      Jogos       Vitorias        Empates         Derrotas        Gols"
 putStrLn (imprimeGrupoB grupoB)
 putStrLn ""
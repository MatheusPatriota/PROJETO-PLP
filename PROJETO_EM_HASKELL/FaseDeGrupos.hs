module FaseDeGrupos where
import EstruturaDoTime
import System.Random
import System.IO.Unsafe

--Transferencias
geraValorAleatorioT :: Int -> Int
geraValorAleatorioT x = unsafePerformIO (randomRIO (0,x))

data Jogador = Jogador{
 nomeJogador :: String,
 posicaoJogador :: String,
 valorJogador :: Int,
 ataqueJogador :: Int,
 controleJogador :: Int,
 defesaJogador :: Int
} deriving (Show)

jogadorAleatorio :: [Jogador] -> Jogador
jogadorAleatorio lista = lista!!(geraValorAleatorioT ((length lista) - 1))

timeAleatorio :: [Time] -> Time
timeAleatorio lista = lista!!(geraValorAleatorioT ((length lista) - 1))

removeJogador :: [Jogador] -> Jogador -> [Jogador]
removeJogador [] _ = []
removeJogador (primeiro:resto) individuo
 | (nomeJogador individuo) == (nomeJogador primeiro) = resto
 | otherwise = [primeiro] ++ (removeJogador resto individuo)

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

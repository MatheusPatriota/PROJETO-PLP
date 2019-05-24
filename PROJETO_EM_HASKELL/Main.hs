-- importando arquivos com funcoes necessarias

import EstruturaDoTime
import FaseDeGrupos
import FinalSemiFinal
import Data.List
import System.IO.Unsafe

-- main fazendo a chamada e os prints
main :: IO()
main = do

 --  criacao statica dos times
 let campinense = Time "Campinense"        77 72 77 76 100
 let treze      = Time "Treze"             73 70 74 72 100
 let botafogo   = Time "Botafogo-PB"       80 76 81 78 100
 let atletico   = Time "Atletico-PB"       58 61 62 59 100
 let souza      = Time "Souza"             63 65 65 68 100
 let nacional   = Time "Nacional de Patos" 59 60 45 61 100
 let serrano    = Time "Serrano"           48 50 56 52 100
 let perilima   = Time "Perilima"          46 50 59 46 100
 let esporte    = Time "Esporte de Patos"  57 62 61 57 100
 let csp        = Time "CSP"               64 66 69 65 100
 --   capital inicial do apostador
 let capital =  2000

 --  times disponiveis nesse campeonato
 putStrLn "Esses são os Times que disputarão o Campeonato Paraibano: "
 putStrLn (nome campinense ++ ", " ++ nome treze ++ ", " ++ nome botafogo ++ ", " ++ nome souza ++ ", " ++ nome nacional ++ ", " ++ nome serrano ++ ", " ++ nome atletico ++ ", " ++ nome perilima ++ ", " ++ nome esporte ++ ", " ++ nome csp)

 --  aumento de capital
 putStrLn ""
 putStrLn "Deseja aumentar o capital das apostas? (s/n) "
 opcao <- getLine
 let cap = seleciona opcao 
 let aux = capital
 let capital = aux + unsafePerformIO (cap)
 
 putStr "Seu capital inicial será de: " 
 print capital
 

 -- Time so pra deixar default na constante AUX
 let timeDefault = Time "Default" 99 99 99 99 99
 let timeNULL   = TimeDeGrupo timeDefault 0 0 0 0 0 0
 let aux        = timeNULL
 let aux2 = 0;
 let auxVencedores = []
 let vencedoresRodada = []
 
 let timesTransferencias = [campinense, treze, botafogo, atletico, souza, nacional, serrano, perilima, esporte, csp]

 --Criando Jogadores
 let j1 = Jogador "xulipa" "zagueiro" 15000 2 5 7 
 let j2 = Jogador "fininn" "zagueiro" 25000 3 6 9 
 let j3 = Jogador "lago" "zagueiro" 12000 1 3 6 
 let j4 = Jogador "genivaldo" "zagueiro" 8000 2 2 4 
 let j5 = Jogador "patrao" "zagueiro" 19000 3 4 10 
 let j6 = Jogador "chefe" "atacante" 19000 7 4 1 
 let j7 = Jogador "tibers" "atacante" 21000 8 4 3 
 let j8 = Jogador "biu" "atacante" 12000 7 3 1 
 let j9 = Jogador "silva" "atacante" 25000 7 6 1 
 let j10 = Jogador "mofi" "atacante" 9000 5 2 1 
 let j11 = Jogador "lima" "meio-campista" 9000 2 6 2 
 let j12 = Jogador "lulu" "meio-campista" 15000 3 7 3 
 let j13 = Jogador "jj" "meio-campista" 11000 3 6 2 
 let j14 = Jogador "pedrao" "meio-campista" 22000 5 10 3 
 let j15 = Jogador "moreira" "meio-campista" 20000 6 9 3

 let jogadores = [j1, j10, j6, j4, j5, j3, j7, j8, j15, j2, j12, j11, j9, j14, j13]
 
 -- Criando times de grupo com seus atributos
 let time1  = TimeDeGrupo campinense 0 0 0 0 0 0
 let time2  = TimeDeGrupo treze      0 0 0 0 0 0
 let time3  = TimeDeGrupo botafogo   0 0 0 0 0 0
 let time4  = TimeDeGrupo atletico   0 0 0 0 0 0
 let time5  = TimeDeGrupo souza      0 0 0 0 0 0
 let time6  = TimeDeGrupo nacional  0 0 0 0 0 0 
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

 let primeiraTransferencia = jogadorAleatorio jogadores
 let timePrimeiraTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux primeiraTransferencia

 let segundaTransferencia = jogadorAleatorio jogadores
 let timeSegundaTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux segundaTransferencia
 
 putStrLn ""
 putStrLn "Mercado de Transferencias "
 putStrLn "---------------------------------------------------------------------------------------------------------"

 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador primeiraTransferencia) ++ " se transferiu para " ++ (nome timePrimeiraTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador primeiraTransferencia)) ++ ".00")
 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador segundaTransferencia) ++ " se transferiu para " ++ (nome timeSegundaTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador segundaTransferencia)) ++ ".00")
 putStrLn ""

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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a primeira Rodada e de "
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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Segunda Rodada e de "
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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Terceira Rodada e de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 3

-- Rodada 4

 let primeiraTransferencia = jogadorAleatorio jogadores
 let timePrimeiraTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux primeiraTransferencia

 let segundaTransferencia = jogadorAleatorio jogadores
 let timeSegundaTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux segundaTransferencia
 
 putStrLn ""
 putStrLn "Mercado de Transferencias "
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador primeiraTransferencia) ++ " se transferiu para " ++ (nome timePrimeiraTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador primeiraTransferencia)) ++ ".00")
 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador segundaTransferencia) ++ " se transferiu para " ++ (nome timeSegundaTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador segundaTransferencia)) ++ ".00")
 putStrLn ""

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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Quarta Rodada e de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 4


-- Rodada 5

 let primeiraTransferencia = jogadorAleatorio jogadores
 let timePrimeiraTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux primeiraTransferencia

 let segundaTransferencia = jogadorAleatorio jogadores
 let timeSegundaTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux segundaTransferencia

 putStrLn ""
 putStrLn "Mercado de Transferencias "
 putStrLn "---------------------------------------------------------------------------------------------------------"

 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador primeiraTransferencia) ++ " se transferiu para " ++ (nome timePrimeiraTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador primeiraTransferencia)) ++ ".00")
 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador segundaTransferencia) ++ " se transferiu para " ++ (nome timeSegundaTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador segundaTransferencia)) ++ ".00")
 putStrLn ""


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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Quinta Rodada e de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 5


 -- Rodada 6


 let primeiraTransferencia = jogadorAleatorio jogadores
 let timePrimeiraTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux primeiraTransferencia

 let segundaTransferencia = jogadorAleatorio jogadores
 let timeSegundaTrasferencia = timeAleatorio timesTransferencias
 let aux = jogadores
 let jogadores = removeJogador aux segundaTransferencia
 
 putStrLn ""
 putStrLn "Mercado de Transferencias "
 putStrLn "---------------------------------------------------------------------------------------------------------"

 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador primeiraTransferencia) ++ " se transferiu para " ++ (nome timePrimeiraTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador primeiraTransferencia)) ++ ".00")
 putStrLn ("O " ++ (posicaoJogador primeiraTransferencia) ++ " " ++ (nomeJogador segundaTransferencia) ++ " se transferiu para " ++ (nome timeSegundaTrasferencia) ++ " em uma transação de R$ " ++ (show (valorJogador segundaTransferencia)) ++ ".00")
 putStrLn ""

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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Sexta Rodada e de "
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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Setima Rodada e de "
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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Oitava Rodada e de "
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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Nona Rodada e de "
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
 print "O usuario gostaria de realizar a segunda aposta? "
 print "se sim, digite o nome do time, caso contrario tecle Enter" 
 putStrLn "" 
 time2 <- getLine
 let auxB = time2:[]

 let aux = auxA ++ auxB

 let auxTimesApostados = verificaStringsVazias aux

 print "Voce apostou nos times: "
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
 

 print "Seu Capital Total apos a Decima Rodada e de "
 print capital
 putStrLn "---------------------------------------------------------------------------------------------------------"
 putStrLn ""
 -- Fim da Rodada 10
 
 let classificadosSemiFinal = getClassificadosSemifinal timesDoGrupoA timesDoGrupoB 
 putStrLn "Classificados para semifinal:"
 putStrLn ((nome (time (fst(fst classificadosSemiFinal)))) ++ " | " ++ (nome (time (snd(fst classificadosSemiFinal)))) ++ " | " ++ (nome (time (fst(snd classificadosSemiFinal)))) ++ " | " ++ (nome (time (snd(snd classificadosSemiFinal)))))

 putStr "Saldo total das Apostas esta em: "
 print capital

-- iniciando finais

 let classificadosSemiFinall = getClassificadosSemifinalL timesDoGrupoA timesDoGrupoB 
 semiFinal classificadosSemiFinall capital
 

import System.Random (randomRIO)
import System.IO.Unsafe

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


----Estrutura de um time na semifinal, nao esquece r----

data TimeSemiEFinais = TimeSemiEFinais {
	timeSF :: Time,
	golsSF :: Int

}deriving(Show)

---Daqui ate o main funcoes que ja existem na fase de grupos

-- Funcao para padronizar o tamanho de strings
validaString :: String -> Int -> String
validaString texto tamanho	| (length texto) < tamanho = (validaString (texto ++ " ") tamanho)
							| otherwise = texto


----Estas funcoes estao na fase de grupos usadas aqui para testar
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


main :: IO()
main = do
		-- Criando times com seus atributos
	let campinense = Time "Campinense"        77 72 77 76 100
	let treze      = Time "Treze"             73 70 74 72 100
	let botafogo   = Time "Botafogo-PB"       80 76 81 78 100
	let atletico   = Time "Atletico-PB"       58 61 62 59 100
	let souza      = Time "Souza"             63 65 65 68 100
	let nacional   = Time "Nacional de Patos" 59 60 45 61 100
	let serrano    = Time "Serrano"           48 50 56 52 100
	let perilima   = Time "Perilima"          46 50 59 46 100
	let esporte    = Time "Esporte de Patos"  57 62 61 57 100
	let csp = Time "CSP" 64 66 69 65 100

	let campinenseSF = TimeSemiEFinais campinense 0
	let botafogoSF = TimeSemiEFinais botafogo 0
	let trezeSF = TimeSemiEFinais treze 0
	let atleticoPBSF = TimeSemiEFinais atletico 0
	let nacionalDePSF = TimeSemiEFinais nacional 0
	--num <- randomIO :: IO Float
	

	--getClassificadosSemifinalL retorna os times de forma ideal para a semifinal
	--Sendo dispensavel o getClassificadosSemifinal da fase de grupos (note o a ultima letra L como diferenca entre as duas)
	---isto devera ficar assim no main: 
	--let classificadosSemiFinall = getClassificadosSemifinalL timesDoGrupoA timesDoGrupoB 
    --semiFinal classificadosSemiFinall capital

	semiFinal ([(nacionalDePSF,atleticoPBSF),(campinenseSF,botafogoSF)]) 100 -- linha apenas para testes



---Tudo que a semifinal precisa é de uma tupla de times do tipo "TimeSemiEFinais" (para isso
---eh necessario apenas passar getClassificadosSemifinalL como argumento) e de um inteiro que é o caixa do apostador 

semiFinal :: [(TimeSemiEFinais,TimeSemiEFinais)] -> Int ->  IO()
semiFinal times saldo = do
	putStrLn ("-------- Fase Semi-Final ---------")
	putStrLn(statusSemiEfinal times)
	putStrLn("\n Deseja Apostar ? Se sim, digite o numero correspondente ao time(1 ou 2), se nao digite qualquer outro numero.\n")

	let timesA = head times
	let timesB = head (tail times)
	let caixa = saldo

	
	--Faz as apostas
	putStr("Aposta1?: ")
	aposta1 <- readLn :: IO Int
	putStr("Aposta2?: ")
	aposta2 <- readLn :: IO Int

	--armazena a partida "A" e da "B"
	let jogoIdaA = calculoDeForca (timeSF(fst timesA)) (timeSF(snd timesA))
	let jogoVoltaA =calculoDeForca (timeSF(fst timesA)) (timeSF(snd timesA))
	let jogoIdaB =calculoDeForca (timeSF(fst timesB)) (timeSF(snd timesB))
	let jogoVoltaB =calculoDeForca  (timeSF(fst timesB)) (timeSF(snd timesB))

	let partidaA = [jogoIdaA,jogoVoltaA]
	let partidaB = [jogoIdaB,jogoVoltaB]	
	--Atualiza os dados dos times.
	let auxTimesA = timesA
	let timesA = atPtTimesPartida auxTimesA partidaA
	let auxTimesB = timesB
	let timesB = atPtTimesPartida auxTimesB partidaB
	
	--Verifica se é necessario ir para os penaltis
	penaltisA <-  penaltisPartida timesA (0,0) 0
 	penaltisB <-  penaltisPartida timesB (0,0) 0
	--Atualiza os pontos dos times a partir de possiveis penaltis

	let auxTimesA = timesA
	let timesA = atPtTimesPenaltis auxTimesA penaltisA
	let auxTimesB = timesB 
	let timesB = atPtTimesPenaltis auxTimesB penaltisB 

	--Já armazena os ganhadores
	let ganhador1 = getGanhador timesA
	let ganhador2 = getGanhador timesB

	-----A partir daqui printa as partida e verifica as apostas-----
	
	---printa a partida do primeiro grupo com os jogos de ida e volta--
	
	putStrLn (partidaPrint timesA 1 partidaA)

	--Se houver penaltis sera mostrado
	putStrLn(printPenaltis timesA penaltisA)
	
	--Verifica o lucro ou perda da aposta
	let valor = verficaAposta timesA aposta1
	putStrLn(printAposta valor)
	let auxCaixa = caixa
	let caixa = auxCaixa + valor

	--printa a partida do segundo grupo com os jogos de ida e volta 
	putStrLn (partidaPrint timesB 1 partidaB)

	--Se houver penaltis sera mostrado
	putStrLn(printPenaltis timesB penaltisB)
	
	--Verifica o lucro ou perda da aposta
	let valor = verficaAposta timesB aposta2
	putStrLn(printAposta valor)
	let auxCaixa = caixa
	let caixa = auxCaixa + valor

	putStrLn("\n---------Seu valor em caixa eh de: " ++ show(caixa) ++" moedas\n")

	---Chama a final para os times vencedores
	putStr("Pressione Enter para prosseguir para a fase Final: ")
	next <- getLine

	finalPartida <- final (ganhador1,ganhador2) (caixa)
	
	print(finalPartida)


	putStrLn("\n ----------------------------------")

---A final é chamada automaticamente pela semifinal(n se preucupar)

final :: (TimeSemiEFinais, TimeSemiEFinais) -> Int ->  IO()
final times saldo = do
			  
	putStrLn("----------- Fase Final -----------")
	putStrLn(statusSemiEfinal [times])
	putStrLn("\n Deseja Apostar ? Se sim, digite o numero correspondente ao time(1 ou 2), se nao digite qualquer outro numero.\n")
	  
	--Faz as apostas
	putStr("Aposta para a Final?: ")
	aposta1 <- readLn :: IO Int
	--Realiza os jogos de ida e volta
	let jogoIda = calculoDeForca (timeSF(fst times)) (timeSF(snd times))
	let jogoVolta = calculoDeForca (timeSF(fst times)) (timeSF(snd times))

	let partidaA = [jogoIda,jogoVolta]--[jogo(head times), jogo (head times)]
	--Atualiza os dados dos times
	let auxTimesA = times
	let times = atPtTimesPartida auxTimesA partidaA
	----verifica se e necessario partida de penaltis e atualiza
	penaltisA <-  penaltisPartida times (0,0) 0
	let auxTimesA = times
	let times = atPtTimesPenaltis auxTimesA penaltisA

	----A partir daui printa as partidas e os penaltis e verifica as apostas---

	--printa a partida com os jogos de ida e volta
	putStrLn (partidaPrint times 1 partidaA)

	--Se houver penaltis sera mostrado
	putStrLn(printPenaltis times penaltisA)
	
	--Verifica o lucro ou perda da aposta
	let valor = verficaAposta times aposta1
	let caixa =  saldo + valor

	--printa a aposta(lucro ou perda) e os status da final 
	putStrLn(printAposta valor)
	let ganhadorFinal = getGanhador times
	putStrLn("---------O grande ganhador do campeonato eh: " ++ validaString(nome(timeSF ganhadorFinal)) 20 ++ "---------\n")
	putStrLn("\n---------Seu valor final em caixa eh de: " ++ show(caixa) ++" moedas\n")

	putStr("\n\nDeseja jogar novamente o campeonato?(digite S ou s para sim): ")
	jogarNovamente <- getLine
	putStrLn "\n\n"
	if (jogarNovamente == ['s'] || jogarNovamente == ['S']) then main
		else putStr(" -----------Fim de jogo-----------")
	--note que o main n precisa chamar mais nada depois da chamada da semifinal.----



getGanhador :: (TimeSemiEFinais,TimeSemiEFinais)-> TimeSemiEFinais
getGanhador (time1,time2)	| (golsSF time1) > (golsSF time2) = time1
							|otherwise = time2


atPtTimesPartida :: (TimeSemiEFinais,TimeSemiEFinais) -> [(Int,Int)] -> (TimeSemiEFinais,TimeSemiEFinais)
atPtTimesPartida (time1, time2) ((pt1,pt2):xs)= (TimeSemiEFinais{
 timeSF = timeSF time1,
 golsSF = pt1 + fst(head xs)},
 TimeSemiEFinais{
 timeSF = timeSF time2,
 golsSF = pt2 + snd(head xs)
 })

atPtTimesPenaltis :: (TimeSemiEFinais,TimeSemiEFinais) -> (Int,Int) -> (TimeSemiEFinais,TimeSemiEFinais)
atPtTimesPenaltis (time1, time2) (pt1,pt2)= (TimeSemiEFinais{
 timeSF = timeSF time1,
 golsSF = (golsSF time1) + pt1 },
 TimeSemiEFinais{
 timeSF = timeSF time2,
 golsSF =(golsSF time2) + pt2 
 })


---mostra quais jogos vao acontecer na semifinal
statusSemiEfinal:: [(TimeSemiEFinais,TimeSemiEFinais)] -> String
statusSemiEfinal [] = ""
statusSemiEfinal ((time1,time2):[]) =  "\n" ++ " 1 " ++ validaString (nome(timeSF time1)) 17  ++  "  vs  " ++  " 2 " ++ validaString(nome(timeSF time2)) 17
statusSemiEfinal ((time1,time2):xs) =  "\n" ++ " 1 " ++ validaString (nome(timeSF time1)) 17  ++  "  vs  " ++  " 2 " ++ validaString(nome(timeSF time2)) 17 ++ "\n" ++ statusSemiEfinal xs



---vai receber os times e placares dos jogos para printar 

statusPartida:: (TimeSemiEFinais,TimeSemiEFinais)-> String
statusPartida (time1,time2) =  "\n" ++ "---------- 1 " ++  validaString (nome(timeSF time1)) 17  ++  "  vs  " ++  " 2 " ++ validaString (nome(timeSF time2)) 17 ++ "----------\n" 


---faz a partida 
partidaPrint :: (TimeSemiEFinais,TimeSemiEFinais) -> Int -> [(Int,Int)] -> String
--O inteiro passado representa o estágio da competicao, 1 ida, 2 volta
partidaPrint (time1,time2) 1 ((pt1,pt2):xs) = statusPartida(time1,time2) ++ " (Jogo de ida)Time " ++ nome(timeSF time1) ++ " joga em casa.\n\n" ++ " 1 " ++  validaString (nome(timeSF time1)) 17 ++ "( " ++ show(pt1) ++ " )     ( " ++ show(pt2) ++ " ) " ++ validaString(nome(timeSF time2)) 17 ++ " 2 \n\n" ++ partidaPrint (time1,time2) 2 xs
partidaPrint (time1,time2) 2 ((pt1,pt2):xs) = " (Jogo de volta)Time " ++ nome(timeSF time2) ++ " joga em casa.\n\n" ++ " 1 " ++  validaString (nome(timeSF time1)) 17 ++ "( " ++ show(pt1) ++ " )     ( " ++ show(pt2) ++ " ) " ++ validaString(nome(timeSF time2)) 17 ++ " 2 "


penaltisPartida :: (TimeSemiEFinais,TimeSemiEFinais) -> (Int,Int) -> (Int) -> IO (Int,Int)
penaltisPartida (time1,time2) placar rodada 	| (golsSF time1) /= (golsSF time2) && rodada == 0 = return (0,0)
												| rodada > 5 && (fst placar) /= (snd placar) = return placar 
												| otherwise  = do
													penalti1 <- batePenalti time1
													penalti2 <-  batePenalti time2
													penaltisPartida (time1,time2) ((fst placar + penalti1), (snd placar + penalti2)) (rodada + 1)




jogaMoeda :: IO Int
jogaMoeda =  randomRIO (0,1 :: Int)


numAleatorio :: IO Int
numAleatorio = randomRIO (40,180 :: Int)


--- bate o penalti
batePenalti :: TimeSemiEFinais -> IO Int
batePenalti time  =  do  
					numaleatorio <- numAleatorio
					moeda <- jogaMoeda
					if numaleatorio  < ((ataque(timeSF(time))) + (defesa(timeSF(time)))) && moeda == 1 
						then  return 1
						else return 0


printPenaltis :: (TimeSemiEFinais,TimeSemiEFinais) -> (Int,Int) -> String
printPenaltis (time1, time2) (0,0) = "\n -----Vitoria decisiva----- \n -------Sem penaltis-------\n"
printPenaltis (time1, time2) placar = "\n ---Partida de penaltis---- \n\n" ++ "   " ++ validaString (nome (timeSF time1)) 17 ++ "( " ++ show(fst(placar)) ++ " )     ( " ++  show(snd(placar)) ++ " ) " ++ validaString (nome (timeSF time2)) 17 ++ "\n ----------------------------------"


verficaAposta :: (TimeSemiEFinais,TimeSemiEFinais) -> Int -> Int
verficaAposta (time1,time2) aposta 	| golsSF time1 > golsSF time2 && aposta == 1 = 100
									| golsSF time1 > golsSF time2 && aposta == 2 = -100
									| golsSF time1 < golsSF time2 && aposta == 2 = 100
									| golsSF time1 < golsSF time2 && aposta == 1 = -100
									|otherwise = 0


printAposta :: Int -> String
printAposta valor	| valor > 0 = "\n Você ganhou " ++ show(valor) ++ " moedas na aposta.\n"
					| valor < 0 = "\n Você perdeu " ++ show(abs valor) ++ " moedas na aposta.\n" 
					|otherwise = "\n Você não apostou!\n"


---Essas funcoes serao uteis na hora de juntar as partes, a funcao abaixo cria um time do tipo 
--TimeSemiEFinais e utilizada pela funcao " getClassificadosSemifinalL"

makeTimeSemiEFinal :: Time -> TimeSemiEFinais
makeTimeSemiEFinal time =TimeSemiEFinais{
 timeSF = time,
 golsSF = 0 }

--essa funcao pega os times classificados na fase de grupos e os retornas de mode correto para a semifinal
getClassificadosSemifinalL :: [TimeDeGrupo] -> [TimeDeGrupo] ->  [(TimeSemiEFinais, TimeSemiEFinais)]
getClassificadosSemifinalL grupoA grupoB = [((makeTimeSemiEFinal (time (grupoA!!0))),(makeTimeSemiEFinal (time (grupoA!!1)))),((makeTimeSemiEFinal (time (grupoB!!0))),(makeTimeSemiEFinal (time (grupoB!!1))))]



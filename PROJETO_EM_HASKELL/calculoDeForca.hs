import System.IO.Unsafe
import System.Random

import Data.List

toInt :: Float -> Int
toInt x = round x

geraValorAleatorio :: Int -> Int
geraValorAleatorio x = x + unsafePerformIO (randomRIO (-x,x))

auxCalculoDeForca :: Int -> Int
auxCalculoDeForca x = toInt(((fromIntegral x) * 0.7)  * 0.01)

calculoDeForca :: Int -> Int -> (Int, Int)
calculoDeForca timeA timeB = do
    let x = auxCalculoDeForca timeA
    let y = auxCalculoDeForca timeB
    (x, y)

data Time = Time {
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    controle :: Int,
    disposicaoFisica :: Int,
    confianca :: Int,
    adefinir :: Int
   } deriving (Show)


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

main :: IO()
main = do

    let vencedoresRodada = ["campinense", "treze"]

    let campinense = Time "Campinense"  77 72 77 76 100 80
    let treze = Time "Treze"  73 70 74 72 100 80


    putStrLn "Bem Vindo ao simulador do Campeonato Paraibano de Futebol 2019"
    putStrLn ""
    putStrLn "Deseja aumentar o capital das apostas? (s/n) "
    opcao <- getLine

    let capital = seleciona opcao

    putStr "Seu capital inicial será de: " 
    print capital

    
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

    print auxTimesApostados


    let auxCapital = capital

    let capital = vencedores vencedoresRodada auxCapital auxTimesApostados
    
    print capital



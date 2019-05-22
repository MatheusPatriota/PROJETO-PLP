-- importando arquivos com funcoes necessarias
import EstruturaDoTime
-- import FaseDeGrupos

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
 let capital = 2000
 putStrLn "Esses são os Times que disputarão o Campeonato Paraibano: "
 putStrLn (nome campinense ++ ", " ++ nome treze ++ ", " ++ nome botafogo ++ ", " ++ nome souza ++ ", " ++ nome nacionalDePatos ++ ", " ++ nome serrano ++ ", " ++ nome atleticoPB ++ ", " ++ nome perilima ++ ", " ++ nome esporteDePatos ++ ", " ++ nome csp)


 putStrLn ""
 putStrLn "Deseja aumentar o capital das apostas? (s/n) "
 opcao <- getLine
 cap <- seleciona opcao 
 let aux = capital
 let capital = aux +  cap
 
 putStr "Seu capital inicial será de: " 
 print capital
 -- exemplo de como atualizar o valor do atributo do time da maneira correta
 let aux = campinense
--  let campinense  = atualizaAtributo  aux 90

 print campinense

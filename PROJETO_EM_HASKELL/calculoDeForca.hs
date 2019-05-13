toInt :: Float -> Int
toInt x = round x

auxCalculoDeForca :: Int -> Int
auxCalculoDeForca x = toInt(((fromIntegral x) * 0.7)  * 0.01)

calculoDeForca :: Int -> Int -> (Int, Int)
calculoDeForca timeA timeB = do
    let x = auxCalculoDeForca timeA
    let y = auxCalculoDeForca timeB
    (x, y)


main :: IO()
main = do
    print (calculoDeForca 300 340)


module ExercisesBoralgra where

-- done by Borja Albert Gramaje (boralgra@alumno.upv.es)

import qualified Data.Char as C
import Distribution.Compat.Lens
import Distribution.Simple.Utils (xargs)

-- 3. Ejercicios sobre tipos básicos

siguienteLetra :: Char -> Char
siguienteLetra x
  | x == 'z' = 'a'
  | x == 'Z' = 'A'
  | otherwise = C.chr (C.ord x + 1)

sumatorio :: (Eq t, Num t) => t -> t -> t
sumatorio x y
  | x == y = y
  | otherwise = y + sumatorio x (y - 1)

productorio :: (Eq t, Num t) => t -> t -> t
productorio x y
  | y == 0 = 1
  | x == y = y
  | otherwise = y * productorio x (y - 1)

getMaximo :: Ord a => a -> a -> a
getMaximo x y
  | x > y = x
  | x < y = y
  | otherwise = x

fact :: (Eq p, Num p) => p -> p
fact x
  | x == 0 = 1
  | x == 1 = 1
  | otherwise = x * fact (x - 1)

sumaFact :: (Eq p, Num p) => p -> p
sumaFact x
  | x == 0 = fact 0
  | x == 1 = fact 1
  | otherwise = fact x + sumaFact (x - 1)

-- 5. Ejercicios sobre tipos listas
-- 5.1
sumListPares :: [(Int, Int)] -> [Int]
sumListPares = concatMap sumPar

sumPar :: (Int, Int) -> [Int]
sumPar x = [uncurry (+) x]

--5.2
getFirst :: [Int] -> Int
getFirst = head

getLast :: [Int] -> Int
getLast = last

--5.3
getListaDivisores :: Int -> [Int]
getListaDivisores n = [x | x <- [1 .. n], n `rem` x == 0]

--5.4
isNumberInList :: Int -> [Int] -> Bool
isNumberInList n l
  | n `elem` l = True
  | otherwise = False

--5.5
replaceNth :: (Eq a, Num a) => a -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth n newVal (x : xs) =
  if x == n
    then do
      newVal : xs
    else x : replaceNth n newVal xs

--5.6
countElemInList :: Eq a => a -> [a] -> Int
countElemInList _ [] = 0
countElemInList item l = length z
  where
    z = [z | z <- l, z == item]

--5.7
multiplesOfIntesional :: Int -> [Int]
multiplesOfIntesional a = [x | x <- [1 ..], x `rem` a == 0]

multiplesOf :: Num a => a -> [a]
multiplesOf x = iterate (+ x) x

--5.8
removeMayus :: [Char] -> [Char]
removeMayus l = [x | x <- l, C.ord x >= 97]

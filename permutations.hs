permutations :: [a] -> [[a]]
permutations xs0 = xs0 : perms xs0 []
  where
    perms [] _ = []
    perms (t:ts) is = foldr interleave (perms ts (t : is)) (permutations is)
      where
        interleave xs r =
          let (_, zs) = interleave' id xs r
           in zs
        interleave' _ [] r = (ts, r)
        interleave' f (y:ys) r =
          let (us, zs) = interleave' (f . (y :)) ys r
           in (y : us, f (t : y : us) : zs)

(>=>) :: (a -> m b) -> (b -> m c) -> (a -> m c)
f >=> g = \a -> f a >>= g

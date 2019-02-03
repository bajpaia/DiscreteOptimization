int : N = 16;
array[1..N,1..N] of var {-1, 1}: hadamard;

constraint forall(i, j in 1..N)
(
  j > i  -> sum(k in 1..N)(hadamard[i, k] * hadamard[j, k]) == 0
);

solve satisfy;
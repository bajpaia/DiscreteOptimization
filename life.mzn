int : N = 3;

set of int: objFunc = 2..N+1;
set of int: constraintCheck = 1..N+2;
set of int: augment = 0..N+3; 

array[augment, augment] of var 0..1: grid;

var int: z = sum(r in objFunc, c in objFunc)(grid[r, c]);

solve:: 
int_search([grid[i, j] | i, j in augment], smallest, indomain_max, complete) maximize z;

constraint forall(x in augment)
(
grid[0, x] = 0 /\ 
grid[1, x] = 0 /\
grid[N + 2, x] = 0 /\
grid[N + 3, x] = 0 /\
grid[x, 0] == 0 /\
grid[x, 1] == 0 /\
grid[x, N + 2] = 0 /\
grid[x, N + 3] = 0
)

/\

  forall(r in constraintCheck,c in constraintCheck) (

    (
      ( ( grid[r-1,c-1] + grid[r-1,c] + grid[r-1,c+1] +
          grid[r,c-1] + grid[r,c+1] +
          grid[r+1,c-1] + grid[r+1,c] + grid[r+1,c+1]
          ) = 3
       ) -> (grid[r,c] = 1)
    )
    /\   

    (
       (grid[r,c] = 1) ->
                      (
                        2 <=
                        ( grid[r-1,c-1] + grid[r-1,c] + grid[r-1,c+1] +
                          grid[r,c-1] + grid[r,c+1] +
                          grid[r+1,c-1] + grid[r+1,c] + grid[r+1,c+1]
                          )
                        /\
                        ( grid[r-1,c-1] + grid[r-1,c] + grid[r-1,c+1] +
                          grid[r,c-1] + grid[r,c+1] +
                          grid[r+1,c-1] + grid[r+1,c] + grid[r+1,c+1]
                          ) <= 3
                      )
    )
  )
   
  /\


  grid[2,2] >= grid[N+1,N+1] /\
  grid[2,N+1] >= grid[N+1,2]
;
 
 
output [
  if j = 0 then "\n" else " " endif ++
    show(grid[i,j])
  | i,j in augment
];
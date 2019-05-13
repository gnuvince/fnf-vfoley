open Printf

let n = 1 lsl 25

let sum_list xs =
  List.fold_left ( +. ) 0.0 xs

let sum_array xs =
  Array.fold_left ( +. ) 0.0 xs

let _ =
  let t1 = Unix.gettimeofday () in
  let a = Array.init n (fun i -> float_of_int (i mod 2)) in
  Array.sort (fun _ _ -> (Random.int 3) - 1) a;
  let t2 = Unix.gettimeofday () in
  printf "array creation: %f seconds\n" (t2 -. t1);
  flush stdout;

  let t1 = Unix.gettimeofday () in
  let l = Array.to_list a in
  let l = List.sort (fun _ _ -> (Random.int 3) - 1) l in
  let t2 = Unix.gettimeofday () in
  printf "list creation: %f seconds\n" (t2 -. t1);
  flush stdout;

  for i = 1 to Array.length Sys.argv - 1 do
    for j = 0 to String.length Sys.argv.(i) - 1 do
      match Sys.argv.(i).[j] with
      | 'l' ->
         begin
           let t1 = Unix.gettimeofday () in
           let sum = sum_list l in
           let t2 = Unix.gettimeofday () in
           printf "sum_list (%f) %f seconds\n" sum (t2 -. t1)
         end
      | 'a' ->
         begin
           let t1 = Unix.gettimeofday () in
           let sum = sum_array a in
           let t2 = Unix.gettimeofday () in
           printf "sum_array (%f) %f seconds\n" sum (t2 -. t1)
         end
      | _ -> ()
    done
  done

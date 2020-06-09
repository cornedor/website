let fact n =
    let result = ref 1 in
    for i = 2 to n do
      result := i * !result
    done;
    !result;;

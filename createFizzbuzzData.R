fizzbuzz = function(n) {
  n = seq_len(n)
  ifelse(n %% 15 == 0, "fizzbuzz",
         ifelse(n %% 5 == 0, "buzz",
                ifelse(n %% 3 == 0, "fizz", "number")))
}

convertBinary = function(n) {
  vapply(seq_len(n), function(x) as.integer(intToBits(x)), 
         FUN.VALUE = numeric(32))
}


createData = function(n) {
  y = fizzbuzz(n)
  
  x = t(convertBinary(n))
  
  data.frame(y, x)
}
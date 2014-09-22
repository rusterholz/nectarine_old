window.Base64 = ->

Base64.digits = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='

Base64.encode = (input) ->
  output = ''
  i = 0
  while i < input.length
    ch1 = input.charCodeAt(i++)
    ch2 = input.charCodeAt(i++)
    ch3 = input.charCodeAt(i++)
    en1 = ch1 >> 2
    en2 = ((ch1 & 3) << 4) | (ch2 >> 4)
    en3 = ((ch2 & 15) << 2) | (ch3 >> 6)
    en4 = ch3 & 63
    if isNaN(ch2)
      en3 = en4 = 64
    else if isNaN(ch3)
      en4 = 64
    output += Base64.digits.charAt(en1) + Base64.digits.charAt(en2) + Base64.digits.charAt(en3) + Base64.digits.charAt(en4)
  output

Base64.decode = (input) ->
  output = ''
  i = 0
  input = input.replace(/[^A-Za-z0-9\+\/\=]/g, '')
  while i < input.length
    en1 = Base64.digits.indexOf(input.charAt(i++))
    en2 = Base64.digits.indexOf(input.charAt(i++))
    en3 = Base64.digits.indexOf(input.charAt(i++))
    en4 = Base64.digits.indexOf(input.charAt(i++))
    ch1 = (en1 << 2) | (en2 >> 4)
    ch2 = ((en2 & 15) << 4) | (en3 >> 2)
    ch3 = ((en3 & 3) << 6) | en4
    output += String.fromCharCode(ch1)
    output += String.fromCharCode(ch2) unless en3 is 64
    output += String.fromCharCode(ch3) unless en4 is 64
  output

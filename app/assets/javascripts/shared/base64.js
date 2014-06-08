window.Base64 = function() {};
window.Base64.keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
window.Base64.encode = function(input) {
  var chr1, chr2, chr3, enc1, enc2, enc3, enc4, i, ks, output;
  output = "";
  ks = Base64.keyStr;
  i = 0;
  while (i < input.length) {
    chr1 = input.charCodeAt(i++);
    chr2 = input.charCodeAt(i++);
    chr3 = input.charCodeAt(i++);
    enc1 = chr1 >> 2;
    enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
    enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
    enc4 = chr3 & 63;
    if (isNaN(chr2)) {
      enc3 = enc4 = 64;
    } else {
      if (isNaN(chr3)) {
        enc4 = 64;
      }
    }
    output += ks.charAt(enc1) + ks.charAt(enc2) + ks.charAt(enc3) + ks.charAt(enc4);
  }
  return output;
};
window.Base64.decode = function(input) {
  var chr1, chr2, chr3, enc1, enc2, enc3, enc4, i, ks, output;
  output = "";
  ks = Base64.keyStr;
  i = 0;
  input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
  while (i < input.length) {
    enc1 = ks.indexOf(input.charAt(i++));
    enc2 = ks.indexOf(input.charAt(i++));
    enc3 = ks.indexOf(input.charAt(i++));
    enc4 = ks.indexOf(input.charAt(i++));
    chr1 = (enc1 << 2) | (enc2 >> 4);
    chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
    chr3 = ((enc3 & 3) << 6) | enc4;
    output += String.fromCharCode(chr1);
    if (enc3 !== 64) {
      output += String.fromCharCode(chr2);
    }
    if (enc4 !== 64) {
      output += String.fromCharCode(chr3);
    }
  }
  return output;
};
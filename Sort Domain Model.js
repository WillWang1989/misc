var map = [];
var re = /(public|private|protected|internal)\s+\w+\s([\w\d_$]+)\s*\{[gets;\s]+\}/g;
var s = $('#txt').val();
var myArray= re.exec(s);
while ((myArray ) !== null)
{
  var o ={};
  o.k = myArray[0];
  o.v = myArray[2]
  map.push(o);
  myArray= re.exec(s);
}
map.sort(function(a, b){
    if(a.k.toLowerCase() < b.k.toLowerCase()) return -1;
    if(a.k.toLowerCase() > b.k.toLowerCase()) return 1;
    return 0;
});
map.join();
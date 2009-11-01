buildHead = function(data){
  return "<div class='header'>My best photos (<a href='" + data.web + "'>" + data.name + "</a>):</div>";
}

buildContent = function(data){
  var content = '';
  for(image in data.images){
    content += "<a href='" + data.images[image].href + "'><img src='" + data.images[image].src + "' /></a>"
  }
  return content;
}

buildFooter = function(data){
  return "<div class='footer'><a class='all' href='http://bestc.am/photographers/" + data.id + "'>Show all (" + data.count + ")</a><div class='small'><a href='http://fabiokuhn.com/'>Get this badge</a> | <a href='http://thebestcamera.com/'>The Best Camera</a></div>";
}

loadBadge = function(){
  document.getElementById('bestcam-badge').innerHTML = buildHead(bestcam_data) + buildContent(bestcam_data) + buildFooter(bestcam_data);
}

document.write('<script onload="loadBadge()" src="http://bestcam.fabiokuhn.com/' + document.getElementById('bestcam-badge').getAttribute('data-id') + '.js" type="text/javascript"></script>');
document.write('<link media="screen" type="text/css" href="http://bestcam.fabiokuhn.com/css/screen.css" rel="stylesheet"/>');

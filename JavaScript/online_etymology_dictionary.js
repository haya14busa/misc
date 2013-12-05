javascript:(function(){var text=encodeURIComponent(window.getSelection());text=(!text)?encodeURIComponent(window.prompt('Online Etymology Dictionary')):text;if(text==='null'||text==='')return;URL1='http://www.etymonline.com/index.php?allowed_in_frame=0&searchmode=none&search='+text;window.open(URL1,'_blank');})();


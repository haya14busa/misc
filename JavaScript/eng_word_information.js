javascript:(function(){var text=encodeURIComponent(window.getSelection());text=(!text)?encodeURIComponent(window.prompt('English-Word Information')):text;if(text==='null'||text==='')return;URL1='http://wordinfo.info/results?searchString='+text;window.open(URL1,'_blank');})();
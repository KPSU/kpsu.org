
function _ajax_loader_black(){
	return "<div id='loader' class='black-ajax-loader'><span class='magenta-text bebas sixteen-pt'>Loading</span><br/><img src='/images/v3/loadinfo.gif'></div>"
} 

function get_unique_id(){
     var dateObject = new Date();
     var uniqueId = 
          dateObject.getFullYear() + '' + 
          dateObject.getMonth() + '' + 
          dateObject.getDate() + '' + 
          dateObject.getTime();

     return uniqueId;
}
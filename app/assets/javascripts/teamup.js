var ownerId;
var candidateList;
var candidateNum;

function init(ownerId, candidateList,candidateNum) {   // init candidate List 
	
	boxDiv = $("#candidateList")
		for(var index = 0; index < candidateList.length ; index ++) {
			var boardDiv = $('<div></div>');
			boardDiv.attr('id','stuBor' + index);
			boardDiv.addClass('bg');
			boardDiv.appendTo(boxDiv);
			var childDiv = $('<div></div>');
			childDiv.attr('id',candidateList[index].id);
			childDiv.addClass('bor');
			childDiv.text(candidateList[index].first_name + candidateList[index].last_name)
				childDiv.appendTo(boardDiv);
		}

	preferenceDiv = $("#preferenceList")  //init preference List
		for(var index = 0; index < candidateNum ; index ++) {
			var boardDiv = $('<div></div>');
			boardDiv.attr('id','pre' + index);
			boardDiv.addClass('bg');
			boardDiv.appendTo(preferenceDiv);
		}
}

function attachDragEffect() {
	var move = false;  
	var $bg = $(".bg"); 
	var initDiv, tarDiv, tarDivHalf = 0, wHalf = 0; //drag object
	var initPos = {x: 0, y: 0}, relPos = {x: 0, y: 0}, temPos = {x: 0, y: 0}; 
	var dragPos = {x1: 0, x2: 0, y1: 0, y2: 0};// drag object position 
	var tarDivPos = {x1: 0, y1: 0, x2: 0, y2: 0}; // target object position
	var sourceParentBg , targetParentBg;
	var swap = false;
	$(".bor").each(function() { 
			$(this).mousedown(function(event) { 
				initDiv = $(this);
				// mouse position 
				relPos.x = event.pageX - $(this).offset().left; 
				relPos.y = event.pageY - $(this).offset().top; 
				move = true; 
				sourceParentBg = initDiv.parent(".bg");
				}); 
			$(document).mousemove(function(event) { 
				if (!move) { return false; } 
				initDiv.removeClass("bor").addClass("borp"); 
				// drag with mouse point 
				dragPos.x1 = event.pageX - relPos.x; 
				dragPos.y1 = event.pageY - relPos.y; 
				dragPos.x2 = dragPos.x1 + initDiv. innerWidth(); 
				dragPos.y2 = dragPos.y1 + initDiv. innerHeight(); 
				initDiv.css({ left: dragPos.x1 +'px', top: dragPos.y1 + 'px' }); 
				$bg.each(function() { 
					tarDiv = $(this); 
					// target position
					tarDivPos.x1 = tarDiv.offset().left; 
					tarDivPos.x2 = tarDivPos.x1 + tarDiv.width(); 
					tarDivPos.y1 = tarDiv.offset().top; 
					tarDivPos.y2 = tarDivPos.y1 + tarDiv.height(); 
					tarDivHalf = tarDiv.height()/2; //half of the height; 
					wHalf = tarDiv.width()/2; 
					if (dragPos.x2 >= tarDivPos.x1 + wHalf && dragPos.x2 <= tarDivPos.x2 + wHalf && dragPos.y2 >= tarDivPos.y1 + tarDivHalf && dragPos.y2 <= tarDivPos.y2 + tarDivHalf ) { 	
					tarDiv.removeClass("bg").addClass("bg bgColor"); 
					} else { 
					tarDiv.removeClass("bgColor"); 
					swap = false;
					} 
					}); 
			}).mouseup (function(event) { 
				if(move == false) return;
				targetParentBg = $(".bgColor");
				if(targetParentBg.children(".bor").length > 0) {  //swap two childDiv
				swapDiv = targetParentBg.children(".bor");
				swapDiv.appendTo(sourceParentBg);
				}
				initDiv.appendTo(targetParentBg);// append new Div to target bg 
				initDiv.removeClass("borp").addClass("bor").removeAttr("style"); //remove the style 
				move = false; 
				});	

	});
}

function sendMyPreference(ownerId, preferList, type) {
	$.ajax({
type : "get",// request method
url : "../choices/create",// target URL
dataType : "json",// return data type
data : {
type : type,
ownerId : ownerId,
preferList : preferList,
},
success : function(jsonData) {
if (jsonData.result == "success") {
alert( type + " success!" + jsonData.preferList);
//location.href = "index.html"; //the page you want to jump 
} else {
alert("fail");	
}

}
});
}

function bindAction() {
	$("#save").click(
			function(event) {
			preferList = getPreferList();
			if(preferList != null) {
			sendMyPreference(ownerId, getPreferList, "save");
			} else {
			alert("left some candidates!");
			}
			});

	$("#submit").click(
			function(event) {
			preferList = getPreferList();
			if(preferList != null) {
			sendMyPreference(ownerId, getPreferList, "submit");
			} else {
			alert("left some candidates!");
			}
			});
}
function fetchCandiatteList() {
	$.ajax({
type : "get",// request method
url : "../choices/getinfo",// target URL(maybe you need some ajustifications to adapt to your project)
dataType : "json",// return data type
data : {
type : "Fetch Candiate List",
},
success : function(jsonData) {
if (jsonData.candidateNum > 0) {
ownerId = jsonData.ownerId;
candidateList = jsonData.candidateList;
candidateNum = jsonData.candidateNum;
init(ownerId, candidateList,candidateNum);
attachDragEffect();
bindAction();
} else {
alert("fail");	
}

}
});
}

function getPreferList() {
	preferenceDiv = $("#preferenceList");  
	preferBox = preferenceDiv.children(".bg");
	preferList = new Array();
	var validcnt = 0 ;
	for(var index = 0; index <  candidateNum; index ++ ) {
		var student = -1;
		if( preferBox[index].children.length > 0 ) {
			student = preferBox[index].children[0].id;
			validcnt ++;
		} 
		preferList.push(student);
	}
	if(validcnt != candidateNum)
		return null;
	else
		return preferList;
}

$(document).ready(function() { 
		var candidateNum = 5;
		var ownerId = 1;

		fetchCandiatteList();



		});

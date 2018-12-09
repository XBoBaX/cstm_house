var globalFlag = 2
var dataFirst = new Date();
var dataSecond = new Date();
var curr_now = new Date();
var listObjec = [];
first();
//00887e

function first(){
    var dataString = new Date()
    var curr = new Date(dataString)

    var dayWeek = 1
    if(curr.getDay()==0) {
        console.log("пн")
        dayWeek = 7;
    }
    else dayWeek = curr.getDay();

    var first = curr.getDate() - (dayWeek - 1);
    var last = first + 6;
    dataFirst = new Date(curr.setDate(first));
    dataSecond = new Date(curr.setDate(last));
}

// 承認ボタン押下時に承認チェックされたレコードのIDを取得
$(document).ready(function() {
  $("#approval_button").bind("click", function() {
    var checked_local_people = $("input:checked");
    var ids = new Array;
    for(i=0;i<checked_local_people.length;i++){
      ids[i] = checked_local_people[i].value;
    }
    $("#approval_local_people").val(ids);
  });
});

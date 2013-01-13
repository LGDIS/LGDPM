// 連携ボタン押下時に連携チェックされたレコードのIDを取得
$(document).ready(function() {
  $("#link_button").bind("click", function() {
    var checked_evacuees = $("input:checked");
    var ids = new Array;
    for(i=0;i<checked_evacuees.length;i++){
      ids[i] = checked_evacuees[i].value;
    }
    $("#link_evacuees").val(ids);
  });
});

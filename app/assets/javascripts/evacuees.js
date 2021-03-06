// Submitボタン切り替え
$(document).ready(function() {
  $(":submit").bind("click", function() {
    $("#commit_kind").val($(this).attr("kind"));
  });
});

// 避難者一覧画面行リンク
$(function($) {
  $('tr[data-href]').addClass('clickable').click(function(e) {
    if (!$(e.target).is('a')) {
      window.location = $(e.target).closest('tr').data('href');
    };
  });
});

// クリアボタン押下時に検索条件をすべて空にする
$(document).ready(function() {
  $("#clear_button").bind("click", function() {
    $(":text").val("");
    $("select").val("");
  });
});

// 避難者住基マッチング候補者選択画面
// 保存ボタン押下時に適用チェックされた住基IDを取得
$(document).ready(function() {
  $("#match_button").bind("click", function() {
    $("#juki_id").val($("input[name='matched']:checked").val());
  });
});

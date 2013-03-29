$(function(){
  $("td #btn-deploy").click(function(e){
    if (confirm("将要执行【上线】操作，是否确定？"))
    {
      var progress = "<div style=\"height:10px;\"><div class=\"progress progress-striped active\"><div class=\"bar\" style=\"width:100%;\"></div></div></div>";
      $(e.target).parent().prev().empty();
      $(e.target).parent().prev().append(progress);
      //$("#td-status").empty();
      //$("#td-status").append(progress);
      return true;
    }
    else
    {
      return false;
    }
  });
});

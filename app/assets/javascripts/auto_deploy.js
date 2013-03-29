$(function(){
  $("td #btn-deploy").click(function(e){
    if (confirm("将要执行【上线】操作，是否确定？"))
    {
      var progress = "<div style=\"height:10px;\"><div class=\"progress progress-striped active\"><div class=\"bar\" style=\"width:100%;\"></div></div></div>";
      $(e.target).parent().prev().empty();
      $(e.target).parent().prev().append(progress);
      return true;
    }
    else
    {
      return false;
    }
  });

  $("td #btn-rollback").click(function(e){
    if (confirm("将要执行【回滚】操作，是否确定？"))
    {
      var progress = "<div style=\"height:10px;\"><div class=\"progress progress-striped active\"><div class=\"bar\" style=\"width:100%;\"></div></div></div>";
      $(e.target).parent().prev().empty();
      $(e.target).parent().prev().append(progress);
      return true;
    }
    else
    {
      return false;
    }
  });

  //$("#machine-table").click(function(e){
  //  alert(e.target.parentNode.outerHTML)
  //});
});

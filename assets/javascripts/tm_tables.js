jQuery(function() {
  $(document).on("click", ".detail", function(event) {
    var select_num;
    select_num = parseInt($('.detail').index(this));
    if ($('.detail').eq(select_num).hasClass("selected")) {
      return $('.detail').eq(select_num).removeClass("selected");
    } else {
      return $('.detail').eq(select_num).addClass("selected");
    }
  });
  $(document).on("click", ".removeList", function(event) {
    if ($('.selected').length === 0) {
      alert("明細が未選択です。");
      return;
    }
    $('.selected').children("input[name*='_destroy']").val('1');
    $('.selected').closest('tr').hide();
    $('.selected').addClass("deleted");
    $('.selected').removeClass("selected");
    $.update_index();
    return event.preventDefault();
  });
  $(document).on("click", ".addList", function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    console.log($('.detail').length);
    if ($('.detail').length === 0) {
      $('.detail_label').after($(this).data('fields').replace(regexp, time));
    } else {
      $('.detail').last().after($(this).data('fields').replace(regexp, time));
    }
    $.update_index();
    return event.preventDefault();
  });
  $(document).on("click", ".upList", function(event) {
    if ($('.selected').length === 0) {
      alert("明細が未選択です。");
      return;
    }
    if ($('.selected').length > 2) {
      alert("複数選択での操作は行えません。");
      return;
    }
    console.log($('.selected').length);
    $('.selected').insertBefore($('.selected').prev());
    $.update_index();
    return event.preventDefault();
  });
  $(document).on("click", ".downList", function(event) {
    if ($('.selected').length === 0) {
      alert("明細が未選択です。");
      return;
    }
    if ($('.selected').length > 2) {
      alert("複数選択での操作は行えません。");
      return;
    }
    console.log($('.selected').length);
    $('.selected').insertAfter($('.selected').next());
    $.update_index();
    return event.preventDefault();
  });
  $.update_index = function() {
    var display_idx;
    display_idx = 0;
    return $('.detail').each(function(idx) {
      display_idx += 1;
      return $(this).find('.detail_no').children().val(display_idx);
    });
  };
  $(document).on("click", ".getgentext", function(event) {
    var url;
    url = location.href　 + '/getgentext';
    console.log($("pre#targetpre").html());
    console.log($("code#targetcode").text());
    return $.ajax({
      url: url,
      type: 'get',
      async: false,
      success: function(text) {
        return $("code#targetcode").text(text);
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
        return alert(XMLHttpRequest + " " + textStatus);
      }
    });
  });
  return $(document).on("click", ".getlocaleyml", function(event) {
    var url;
    url = location.href　 + '/getlocaleyml';
    return $.ajax({
      url: url,
      type: 'get',
      async: false,
      success: function(text) {
        return $("code#targetcode").text(text);
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
        return alert(XMLHttpRequest + " " + textStatus);
      }
    });
  });
});


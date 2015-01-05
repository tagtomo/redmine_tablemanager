jQuery(function() {
  $(document).on("click", ".detail", function(event) {
    var select_num;
    select_num = parseInt($('.detail').index(this));
    if ($('.detail').eq(select_num).hasClass("tbm_selected")) {
      $('.detail').eq(select_num).removeClass("active");
      return $('.detail').eq(select_num).removeClass("tbm_selected");
    } else {
      $('.detail').eq(select_num).addClass("active");
      return $('.detail').eq(select_num).addClass("tbm_selected");
    }
  });
  $(document).on("click", ".removeList", function(event) {
    if ($('.tbm_selected').length === 0) {
      alert("明細が未選択です。");
      return;
    }
    $('.tbm_selected').children("input[name*='_destroy']").val('1');
    $('.tbm_selected').closest('tr').hide();
    $('.tbm_selected').addClass("deleted");
    $('.tbm_selected').removeClass("tbm_selected");
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
    if ($('.tbm_selected').length === 0) {
      alert("明細が未選択です。");
      return;
    }
    if ($('.tbm_selected').length > 1) {
      alert("複数選択での操作は行えません。");
      return;
    }
    console.log($('.tbm_selected').length);
    $('.tbm_selected').insertBefore($('.tbm_selected').prev());
    $.update_index();
    return event.preventDefault();
  });
  $(document).on("click", ".downList", function(event) {
    if ($('.tbm_selected').length === 0) {
      alert("明細が未選択です。");
      return;
    }
    if ($('.tbm_selected').length > 1) {
      alert("複数選択での操作は行えません。");
      return;
    }
    console.log($('.tbm_selected').length);
    $('.tbm_selected').insertAfter($('.tbm_selected').next());
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


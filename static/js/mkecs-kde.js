function show_dataset(evt, series) {
  var i, dataset_display, dataset_control_tab;
  dataset_display = document.getElementsByClassName("dataset_display");
  for (i = 0; i < dataset_display.length; i++) {
    dataset_display[i].style.display = "none";
  }
  dataset_control_tab = document.getElementsByClassName("dataset_control_tab");
  for (i = 0; i < dataset_control_tab.length; i++) {
    dataset_control_tab[i].className = dataset_control_tab[i].className.replace(" active", "");
  }
  document.getElementById(series).style.display = "block";
  evt.currentTarget.className += " active";
}

$(document).ready(function() {
  $("#kde_form_exe").click(function() {
    $("#session_start").html('Loading <i class = "fas fa-spinner fa-spin"></i>')
  });
});

$(document).ready(function() {
  $("#kde_form_res").click(function() {
    $("#session_start").html('Loading <i class = "fas fa-spinner fa-spin"></i>')
  });
});

$(document).ready(function() {
  $("#kde_form_exe").click(function() {
    $("#kde_form_exe").hide();
    $("#kde_form_exe_disabled").show();
  });
});
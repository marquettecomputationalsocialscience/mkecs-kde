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
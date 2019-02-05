function concur() {
      var tos_concur = document.getElementById("tos_form_submit_concur_cb");
      var tos_concur_exe = document.getElementById("tos_form_submit_concur_exe");
      if (tos_concur.checked == true){
        tos_concur_exe.style.display = "block";
      } else {
        tos_concur_exe.style.display = "none";
      }
    }
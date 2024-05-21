$(document).ready(function () {
  //AJAX for CRUD on option
  $("#service_options_container").on("click", function (event) {
    event.preventDefault();
    let item = event.target;
    let element = $(item);
    if (element.hasClass("delete_option_btn")) {
      serviceId = element.data("service-id");
      optionId = element.data("option-id");
      $.ajax({
        method: "DELETE",
        url: "/services/" + serviceId + "/options/" + optionId,
        success: function () {
          $("#option_" + optionId).remove();
        },
        error: function (error) {
          console.error("Error deleting option:", error);
          console.log(error);
        },
      });
    } else if (element.hasClass("update_option_btn")) {
      optionId = element.data("option-id");
      serviceId = element.data("service-id");
      form = element.parent();
      var formData = new FormData(form[0]);
      $.ajax({
        method: "PATCH",
        url: "/services/" + serviceId + "/options/" + optionId,
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
          $("#option_" + optionId).replaceWith($(response));
        },
        error: function (error) {
          console.error("Error updating option:", error);
        },
      });
    }
  });

  //AJAX for creating an option
  $("#create_option_form")
    .off("submit")
    .on("submit", function (event) {
      event.preventDefault();

      var formData = new FormData($(this)[0]);
      var serviceId = $(this).data("service-id");
      $.ajax({
        method: "POST",
        url: "/services/" + serviceId + "/options",
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
          $("#no_options").remove();
          $("#service_options_container").append($(response));
          $("#create_option_form")[0].reset();
        },
        error: function (error) {
          console.error("Error creating option:", error);
        },
      });
    });
});

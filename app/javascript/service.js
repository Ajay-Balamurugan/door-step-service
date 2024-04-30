$(document).ready(function () {
  //AJAX for CRUD on service
  $("#services_container").on("click", function (event) {
    let item = event.target;
    let element = $(item);
    if (element.hasClass("delete_service_btn")) {
      serviceId = element.data("service-id");
      $.ajax({
        method: "DELETE",
        url: "/services/" + serviceId,
        success: function (response) {
          $("#service_" + serviceId).remove();
        },
        error: function (error) {
          console.error("Error deleting service:", error);
        },
      });
    } else if (element.hasClass("update_service_btn")) {
      event.preventDefault();
      serviceId = element.data("service-id");
      form = element.parent();
      var formData = new FormData(form[0]);

      $.ajax({
        method: "PUT",
        url: "/services/" + serviceId,
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
          $("#service_" + serviceId).replaceWith($(response));
        },
        error: function (error) {
          console.error("Error updating service:", error);
        },
      });
    }
  });

  //AJAX for creating a service
  $("#create_service_form").on("submit", function (event) {
    event.preventDefault();

    var formData = new FormData($("#create_service_form")[0]);

    $.ajax({
      type: "POST",
      url: "/services",
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        $("#no_services").remove();
        $("#services_container").prepend($(response));
        $("#create_service_form")[0].reset();
      },
      error: function (error) {
        console.error("Error creating service:", error);
      },
    });
  });
});
